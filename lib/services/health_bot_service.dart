import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// AI Health Bot service for symptom analysis.
/// Uses Groq API with a carefully structured prompt that includes
/// Kerala/Kasaragod regional disease context and safety rules.
class HealthBotService {
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  static String get _apiKey => dotenv.env['GROQ_API_KEY'] ?? '';

  /// System prompt that establishes the AI as a careful health assistant
  /// with Kerala/Kasaragod regional awareness.
  static const String _systemPrompt = '''
You are a GENERAL HEALTH GUIDANCE assistant (NOT a doctor, NOT a medical professional) for people in Kerala, India, especially the Kasaragod district.

⚠️ CRITICAL SAFETY RULES — YOU MUST FOLLOW THESE AT ALL TIMES:
1. You are NOT providing a medical diagnosis. You are ONLY listing POSSIBLE conditions based on reported symptoms.
2. NEVER give a definitive diagnosis. ALWAYS say "This MAY indicate" or "POSSIBLE condition" — NEVER say "You have" or "This is."
3. NEVER prescribe specific medications or dosages. NEVER say "Take 500mg of..." or "Use this medicine."
4. NEVER replace a doctor. You are a preliminary guidance tool ONLY.
5. ALWAYS end your response with: "⚕️ IMPORTANT: This is NOT a medical diagnosis. Please consult a qualified doctor for proper examination, diagnosis, and treatment."
6. If unsure, say "I cannot determine this — please see a doctor."

REGIONAL AWARENESS (Kerala / Kasaragod):
- Common regional diseases: Dengue fever, Chikungunya, Leptospirosis, Influenza, Food poisoning, Heat exhaustion, Typhoid, Malaria.
- Seasonal patterns: Monsoon (June–September) increases mosquito-borne and waterborne disease risk.
- Local environment: Tropical climate, high humidity, coastal area exposure.

LANGUAGE:
- Understand English, Malayalam, and English-Malayalam mixed input (Manglish).
- Example: "Enikku fever undu, body pain undu" means "I have fever, I have body pain."
- Always respond in clear English.

RESPONSE FORMAT (use this EXACT structure with these EXACT headers):

🚦 RISK LEVEL: [LOW / MODERATE / HIGH / EMERGENCY]
(LOW = monitor at home, MODERATE = visit clinic soon, HIGH = seek medical care today, EMERGENCY = go to hospital immediately)

📋 SYMPTOMS DETECTED:
• List each symptom detected (bullet points)

🔍 POSSIBLE CONDITIONS (These are NOT diagnoses):
• Condition name — Possibility level (High / Medium / Low)
• Include regional diseases if symptoms match
• ALWAYS note: "These are possibilities only, not confirmed diagnoses"

🏠 HOME CARE GUIDANCE:
• Safe general advice: hydration, rest, monitoring
• NEVER recommend specific medication or dosage
• You may say "Over-the-counter fever reducers may help — consult a pharmacist for appropriate options"

⚠️ WARNING SIGNS TO WATCH:
• List dangerous symptoms that need immediate attention

🏥 WHEN TO VISIT HOSPITAL:
• Clear guidance on when to seek medical care
• Suggest: Kasaragod District Hospital or Government Medical College Kasaragod if in the area

⚕️ IMPORTANT: This is NOT a medical diagnosis. Please consult a qualified doctor for proper examination, diagnosis, and treatment.

EMERGENCY DETECTION:
- If symptoms sound life-threatening (very high fever >39°C, difficulty breathing, chest pain, loss of consciousness, continuous vomiting, severe bleeding), start response with:
  "🚨 EMERGENCY: Please seek immediate medical attention! Call 108 (Kerala Ambulance) or go to the nearest hospital NOW."
  And set RISK LEVEL to EMERGENCY.
''';

  /// Analyze symptoms and return structured health guidance.
  ///
  /// [symptoms] - User's symptom description (English, Malayalam, or mixed).
  /// [language] - The language to respond in (e.g., 'Malayalam', 'Hindi').
  /// Returns formatted health analysis string.
  static Future<String> analyzeSymptoms(String symptoms, {String language = 'English'}) async {
    if (_apiKey.isEmpty || _apiKey == 'YOUR_API_KEY_HERE') {
      return 'Error: Please add your Groq API key to the .env file.';
    }

    final languageInstruction = language == 'English'
        ? 'Respond in clear English.'
        : 'Respond ENTIRELY in $language language. Use $language script. '
          'Keep the emoji headers (🚦, 📋, 🔍, 🏠, ⚠️, 🏥, ⚕️) and structure the same, '
          'but write ALL text content in $language.';

    final userPrompt =
        'Patient description: "$symptoms"\n\n'
        'Analyze the above symptoms following the response format specified. '
        'Be careful, accurate, and helpful.\n\n'
        '$languageInstruction';

    const int maxRetries = 5;

    try {
      final url = Uri.parse(_baseUrl);

      final body = jsonEncode({
        'model': 'llama-3.3-70b-versatile',
        'messages': [
          {
            'role': 'system',
            'content': _systemPrompt,
          },
          {
            'role': 'user',
            'content': userPrompt,
          }
        ],
        'temperature': 0.3,
        'max_tokens': 1000,
      });

      for (int attempt = 0; attempt <= maxRetries; attempt++) {
        if (attempt > 0) {
          final waitSeconds = (5 * (1 << (attempt - 1))).clamp(5, 60);
          await Future.delayed(Duration(seconds: waitSeconds));
        }

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_apiKey',
          },
          body: body,
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final choices = data['choices'] as List?;
          if (choices != null && choices.isNotEmpty) {
            final message = choices[0]['message'];
            final content = message['content']?.toString().trim();
            if (content != null && content.isNotEmpty) {
              return content;
            }
          }
          return 'No analysis received from API.';
        } else if (response.statusCode == 429) {
          if (attempt == maxRetries) {
            return 'Rate limited (429). Please wait 1 minute and try again.';
          }
          continue;
        } else {
          return 'API Error (${response.statusCode}): ${response.reasonPhrase}';
        }
      }

      return 'Failed after $maxRetries retries. Please try again later.';
    } catch (e) {
      return 'Connection error: $e';
    }
  }
}
