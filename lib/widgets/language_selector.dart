import 'package:flutter/material.dart';

/// Dropdown widget for selecting the target patient language.
/// Supports Malayalam, Hindi, Bengali, and Tamil.
class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onChanged;

  /// Available languages for translation.
  static const List<String> languages = [
    'English',
    'Malayalam',
    'Hindi',
    'Bengali',
    'Tamil',
    'Kannada',
    'Tulu',
    'Konkani',
    'Beary (Beary Bashe)',
    'Marathi',
    'Urdu',
  ];

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.language, color: Color(0xFF4A90D9), size: 28),
        const SizedBox(width: 12),
        const Text(
          'Patient Language:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF4A90D9)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedLanguage,
                isExpanded: true,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1A1A2E),
                ),
                items: languages.map((lang) {
                  return DropdownMenuItem(
                    value: lang,
                    child: Text(lang),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) onChanged(value);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
