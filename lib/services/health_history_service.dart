import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for storing and retrieving user health history locally.
/// Uses SharedPreferences for persistent storage.
class HealthHistoryService {
  static const String _storageKey = 'health_history';

  /// Save a new health entry.
  static Future<void> saveEntry(HealthEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await getAllEntries();
    entries.insert(0, entry); // Newest first

    // Keep only last 50 entries
    final trimmed = entries.take(50).toList();
    final jsonList = trimmed.map((e) => e.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }

  /// Get all saved health entries.
  static Future<List<HealthEntry>> getAllEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null || jsonString.isEmpty) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((j) => HealthEntry.fromJson(j as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Clear all health history.
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  /// Detect recurring symptoms from history.
  /// Returns symptoms that appeared in 3+ separate entries.
  static Future<Map<String, int>> getRecurringSymptoms() async {
    final entries = await getAllEntries();
    final freq = <String, int>{};
    for (final entry in entries) {
      for (final symptom in entry.symptoms) {
        freq[symptom] = (freq[symptom] ?? 0) + 1;
      }
    }
    // Only return symptoms with 3+ occurrences
    freq.removeWhere((_, count) => count < 3);
    final sorted = freq.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sorted);
  }
}

/// A single health history entry.
class HealthEntry {
  final DateTime date;
  final List<String> symptoms;
  final String riskLevel;
  final String summary; // Brief AI analysis snippet
  final String? fullAnalysis;

  HealthEntry({
    required this.date,
    required this.symptoms,
    required this.riskLevel,
    required this.summary,
    this.fullAnalysis,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'symptoms': symptoms,
        'riskLevel': riskLevel,
        'summary': summary,
        'fullAnalysis': fullAnalysis,
      };

  factory HealthEntry.fromJson(Map<String, dynamic> json) {
    return HealthEntry(
      date: DateTime.parse(json['date'] as String),
      symptoms: List<String>.from(json['symptoms'] as List),
      riskLevel: json['riskLevel'] as String? ?? 'LOW',
      summary: json['summary'] as String? ?? '',
      fullAnalysis: json['fullAnalysis'] as String?,
    );
  }
}
