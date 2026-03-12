import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Service that handles AI-powered medical translation and prescription explanation
/// using Groq API.
class TranslationService {
  /// Groq API endpoint
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  /// Get API key from .env
  static String get _apiKey => dotenv.env['GROQ_API_KEY'] ?? '';

  /// Map language names to speech recognition locale codes.
  static const Map<String, String> speechLocaleCodes = {
    'Malayalam': 'ml_IN',
    'Hindi': 'hi_IN',
    'Bengali': 'bn_IN',
    'Tamil': 'ta_IN',
    'Kannada': 'kn_IN',
    'Tulu': 'kn_IN',          // Tulu uses Kannada locale (closest)
    'Konkani': 'kn_IN',       // Konkani uses Kannada locale (closest)
    'Beary (Beary Bashe)': 'ml_IN', // Beary uses Malayalam locale (closest)
    'Marathi': 'mr_IN',
    'Urdu': 'ur_IN',
  };

  /// Translate text FROM a patient's language TO English for the doctor.
  ///
  /// [text] - Text in the patient's language.
  /// [language] - The patient's language name.
  /// Returns the English translation.
  static Future<String> translateToEnglish(
      String text, String language) async {
    final prompt =
        'The following text is in $language spoken by a patient in a hospital. '
        'Translate it into clear, simple English for the doctor. '
        'Return ONLY the English translation, nothing else:\n\n$text';

    return await _callGroq(prompt);
  }

  /// Translate a medical instruction into the selected language.
  ///
  /// [text] - The English medical instruction to translate.
  /// [language] - Target language name (e.g., "Malayalam", "Hindi").
  /// Returns the translated text string.
  static Future<String> translateInstruction(
      String text, String language) async {
    final prompt =
        'Translate the following medical instruction into simple $language '
        'so that a patient can understand it easily. '
        'Return ONLY the translated text, nothing else:\n\n$text';

    return await _callGroq(prompt);
  }

  /// Explain a prescription in simple terms in the selected language.
  ///
  /// [text] - The prescription or medicine instruction to explain.
  /// [language] - Target language name.
  /// Returns a simplified explanation in the target language.
  static Future<String> explainPrescription(
      String text, String language) async {
    final prompt =
        'Explain this medical prescription in very simple $language '
        'for a patient with no medical knowledge. '
        'Make it easy to understand. '
        'Return ONLY the explanation, nothing else:\n\n$text';

    return await _callGroq(prompt);
  }

  /// Internal method to call Groq API with a prompt.
  /// Includes retry logic with exponential backoff for 429 rate-limit errors.
  static Future<String> _callGroq(String prompt) async {
    if (_apiKey.isEmpty || _apiKey == 'YOUR_API_KEY_HERE') {
      return 'Error: Please add your Groq API key to the .env file.';
    }

    const int maxRetries = 5;

    try {
      final url = Uri.parse(_baseUrl);

      final body = jsonEncode({
        'model': 'llama-3.3-70b-versatile',
        'messages': [
          {
            'role': 'user',
            'content': prompt,
          }
        ],
        'temperature': 0.3,
        'max_tokens': 500,
      });

      // Retry loop for rate limiting (429)
      for (int attempt = 0; attempt <= maxRetries; attempt++) {
        // Add a small delay before each request to avoid bursts
        if (attempt > 0) {
          // Exponential backoff: 5s, 10s, 20s, 40s, 60s
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
          return 'No translation received from API.';
        } else if (response.statusCode == 429) {
          // Rate limited — will retry if attempts remain
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
