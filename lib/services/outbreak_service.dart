import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// A single anonymous symptom report from a citizen.
class SymptomReport {
  final List<String> symptoms;
  final String location; // District/area name
  final DateTime timestamp;
  final String? additionalNotes;

  SymptomReport({
    required this.symptoms,
    required this.location,
    required this.timestamp,
    this.additionalNotes,
  });

  Map<String, dynamic> toJson() => {
        'symptoms': symptoms,
        'location': location,
        'timestamp': timestamp.toIso8601String(),
        'notes': additionalNotes ?? '',
      };
}

/// A simulated pharmacy data signal.
class PharmacySignal {
  final String medicineCategory; // e.g., "Fever medicines", "Painkillers"
  final String location;
  final int salesIncrease; // percentage increase
  final DateTime timestamp;

  PharmacySignal({
    required this.medicineCategory,
    required this.location,
    required this.salesIncrease,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'medicine': medicineCategory,
        'location': location,
        'salesIncrease': '$salesIncrease%',
        'timestamp': timestamp.toIso8601String(),
      };
}

/// AI-generated outbreak alert.
class OutbreakAlert {
  final String title;
  final String riskLevel; // Low, Medium, High, Critical
  final String description;
  final String location;
  final DateTime detectedAt;

  OutbreakAlert({
    required this.title,
    required this.riskLevel,
    required this.description,
    required this.location,
    required this.detectedAt,
  });
}

/// Service managing the Disease Early Warning Network.
/// Stores symptom reports locally, runs AI pattern analysis,
/// and generates outbreak alerts.
class OutbreakService {
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  static String get _apiKey => dotenv.env['GROQ_API_KEY'] ?? '';

  /// In-memory storage of symptom reports (simulating a database).
  static final List<SymptomReport> _reports = [];

  /// In-memory pharmacy signals.
  static final List<PharmacySignal> _pharmacySignals = [];

  /// Cached analysis result.
  static String lastAnalysis = '';

  /// Kerala districts for location selection.
  static const List<String> keralaDistricts = [
    'Kasaragod',
    'Kannur',
    'Wayanad',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Thrissur',
    'Ernakulam',
    'Idukki',
    'Kottayam',
    'Alappuzha',
    'Pathanamthitta',
    'Kollam',
    'Thiruvananthapuram',
  ];

  /// Common reportable symptoms.
  static const List<String> reportableSymptoms = [
    'Fever',
    'Headache',
    'Body pain',
    'Vomiting',
    'Diarrhea',
    'Skin rash',
    'Cough',
    'Cold / Runny nose',
    'Sore throat',
    'Fatigue',
    'Joint pain',
    'Stomach pain',
    'Eye redness',
    'Difficulty breathing',
    'Loss of taste/smell',
  ];

  /// Pharmacy medicine categories.
  static const List<String> medicineCategories = [
    'Fever medicines (Paracetamol)',
    'Painkillers (Ibuprofen)',
    'Anti-vomiting drugs',
    'Oral rehydration salts (ORS)',
    'Cough syrups',
    'Antihistamines',
    'Anti-diarrheal medicines',
    'Antibiotics',
  ];

  /// Submit a new anonymous symptom report.
  static void submitReport(SymptomReport report) {
    _reports.add(report);
  }

  /// Submit a pharmacy signal.
  static void submitPharmacySignal(PharmacySignal signal) {
    _pharmacySignals.add(signal);
  }

  /// Get total reports count.
  static int get totalReports => _reports.length;

  /// Get reports from last 7 days.
  static List<SymptomReport> get recentReports {
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    return _reports.where((r) => r.timestamp.isAfter(cutoff)).toList();
  }

  /// Get a summary of symptom frequencies for display.
  static Map<String, int> getSymptomFrequencies() {
    final freq = <String, int>{};
    for (final report in recentReports) {
      for (final symptom in report.symptoms) {
        freq[symptom] = (freq[symptom] ?? 0) + 1;
      }
    }
    // Sort by frequency
    final sorted = freq.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sorted);
  }

  /// Get location-wise report counts.
  static Map<String, int> getLocationCounts() {
    final counts = <String, int>{};
    for (final report in recentReports) {
      counts[report.location] = (counts[report.location] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sorted);
  }

  /// Run AI pattern analysis on collected data.
  /// Returns a structured analysis string.
  static Future<String> runPatternAnalysis() async {
    if (_apiKey.isEmpty || _apiKey == 'YOUR_API_KEY_HERE') {
      return 'Error: Please add your Groq API key to the .env file.';
    }

    // Build data summary for AI
    final recentData = recentReports;
    final symptomFreq = getSymptomFrequencies();
    final locationCounts = getLocationCounts();

    if (recentData.isEmpty) {
      return 'No symptom reports yet. Submit reports to enable AI pattern analysis.';
    }

    // Format reports for AI
    final reportsJson = recentData.map((r) => r.toJson()).toList();
    final pharmacyJson = _pharmacySignals.map((s) => s.toJson()).toList();

    final prompt = '''
You are an AI disease surveillance analyst for Kerala, India (especially Kasaragod district).

Analyze the following community health data and provide an outbreak risk assessment.

SYMPTOM REPORTS (Last 7 days):
${jsonEncode(reportsJson)}

SYMPTOM FREQUENCIES:
${symptomFreq.entries.map((e) => '${e.key}: ${e.value} reports').join('\n')}

LOCATION DISTRIBUTION:
${locationCounts.entries.map((e) => '${e.key}: ${e.value} reports').join('\n')}

${pharmacyJson.isNotEmpty ? 'PHARMACY SIGNALS:\n${jsonEncode(pharmacyJson)}' : 'No pharmacy data available.'}

TOTAL REPORTS: ${recentData.length}

Provide your analysis in this EXACT format:

📊 DATA SUMMARY:
• Total reports analyzed: [number]
• Most reported symptoms: [list]
• Most affected areas: [list]

🔍 PATTERN ANALYSIS:
• Identify any unusual symptom clusters
• Note geographic concentration
• Compare with known Kerala/Kasaragod disease patterns (Dengue, Chikungunya, Leptospirosis, etc.)

🚨 RISK ASSESSMENT:
• [Disease name] — [Risk Level: Low/Medium/High/Critical]
• Explain reasoning for the risk level

⚠️ ALERT LEVEL: [GREEN / YELLOW / ORANGE / RED]
• GREEN: Normal activity
• YELLOW: Unusual patterns detected, monitor closely
• ORANGE: Significant risk, recommend precautionary action
• RED: High outbreak risk, recommend immediate action

📋 RECOMMENDED ACTIONS:
• What should health authorities do
• What should the community do
• Specific disease prevention steps

🏥 HOSPITAL PREPAREDNESS:
• Suggested actions for local hospitals

RULES:
- Base analysis ONLY on the reported data
- Consider seasonal patterns in Kerala (monsoon = more vector-borne diseases)
- Be honest if data is insufficient for strong conclusions
- Never overstate risk — false alarms are harmful
''';

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
        'max_tokens': 1200,
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
              lastAnalysis = content;
              return lastAnalysis;
            }
          }
          return 'No analysis received.';
        } else if (response.statusCode == 429) {
          if (attempt == maxRetries) {
            return 'Rate limited. Please wait 1 minute and try again.';
          }
          continue;
        } else {
          return 'API Error (${response.statusCode}): ${response.reasonPhrase}';
        }
      }

      return 'Failed after retries. Please try again later.';
    } catch (e) {
      return 'Connection error: $e';
    }
  }

  /// Add demo data for testing purposes.
  static void addDemoData() {
    final now = DateTime.now();
    final locations = ['Kasaragod', 'Kasaragod', 'Kasaragod', 'Kannur', 'Kannur'];
    final symptomSets = [
      ['Fever', 'Headache', 'Body pain'],
      ['Fever', 'Body pain', 'Joint pain'],
      ['Fever', 'Skin rash', 'Headache'],
      ['Fever', 'Vomiting', 'Headache'],
      ['Cough', 'Cold / Runny nose', 'Sore throat'],
      ['Fever', 'Body pain', 'Fatigue'],
      ['Diarrhea', 'Vomiting', 'Stomach pain'],
      ['Fever', 'Headache', 'Eye redness'],
    ];

    for (int i = 0; i < symptomSets.length; i++) {
      _reports.add(SymptomReport(
        symptoms: symptomSets[i],
        location: locations[i % locations.length],
        timestamp: now.subtract(Duration(hours: i * 8)),
      ));
    }

    // Add pharmacy signals
    _pharmacySignals.add(PharmacySignal(
      medicineCategory: 'Fever medicines (Paracetamol)',
      location: 'Kasaragod',
      salesIncrease: 300,
      timestamp: now.subtract(const Duration(hours: 12)),
    ));
    _pharmacySignals.add(PharmacySignal(
      medicineCategory: 'Painkillers (Ibuprofen)',
      location: 'Kasaragod',
      salesIncrease: 200,
      timestamp: now.subtract(const Duration(hours: 6)),
    ));
  }
}
