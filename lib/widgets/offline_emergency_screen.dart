import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/offline_data_service.dart';
import '../services/tts_service.dart';
import '../services/app_localizations.dart';

/// Offline Emergency screen.
/// Provides pre-translated medical phrases, first aid steps, and
/// emergency contacts — all without internet.
class OfflineEmergencyScreen extends StatefulWidget {
  final String selectedLanguage;

  const OfflineEmergencyScreen({super.key, required this.selectedLanguage});

  @override
  State<OfflineEmergencyScreen> createState() => _OfflineEmergencyScreenState();
}

class _OfflineEmergencyScreenState extends State<OfflineEmergencyScreen> {
  final TtsService _ttsService = TtsService();
  String _selectedCategory = 'Emergency';

  @override
  Widget build(BuildContext context) {
    final categories = OfflineDataService.categories;
    final phrases = OfflineDataService.getPhrasesByCategory(_selectedCategory);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      child: Column(
        children: [
          // Offline badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              elevation: 0,
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.wifi_off, color: Color(0xFF2E7D32), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.get('offlineEmergencyMode'),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            AppLocalizations.get('allOffline'),
                            style: TextStyle(fontSize: 13, color: Color(0xFF2E7D32)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Emergency numbers (with multi-language labels)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.red.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.red.shade700, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.get('emergencyNumbers'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...OfflineDataService.emergencyContacts.map((contact) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: InkWell(
                            onTap: () => launchUrl(Uri.parse('tel:${contact.number}')),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      contact.getLabel(widget.selectedLanguage),
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.red.shade200),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.call, size: 16, color: Colors.red.shade800),
                                        const SizedBox(width: 6),
                                        Text(
                                          contact.number,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),

          // Category selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF2C5F8A) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF2C5F8A) : Colors.grey.shade400,
                          ),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? Colors.white : const Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Phrases
          ...phrases.map((phrase) => _PhraseCard(
                phrase: phrase,
                selectedLanguage: widget.selectedLanguage,
                ttsService: _ttsService,
              )),

          const SizedBox(height: 12),

          // First Aid Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Icon(Icons.medical_services, color: Colors.red.shade700, size: 22),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.get('firstAidGuide'),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                ),
              ],
            ),
          ),

          ...OfflineDataService.firstAidSteps.map((step) => _FirstAidCard(
                step: step,
                selectedLanguage: widget.selectedLanguage,
                ttsService: _ttsService,
              )),
        ],
      ),
    );
  }
}

class _PhraseCard extends StatelessWidget {
  final OfflinePhrase phrase;
  final String selectedLanguage;
  final TtsService ttsService;

  const _PhraseCard({
    required this.phrase,
    required this.selectedLanguage,
    required this.ttsService,
  });

  @override
  Widget build(BuildContext context) {
    final translation = phrase.getTranslation(selectedLanguage);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // English text
            Text(
              phrase.english,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 6),
            // Translation
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F4FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                translation,
                style: const TextStyle(fontSize: 18, color: Color(0xFF1A1A2E), height: 1.4),
              ),
            ),
            const SizedBox(height: 8),
            // TTS buttons
            Row(
              children: [
                _ttsButton('🔊 English', () => ttsService.speak(phrase.english, 'English')),
                const SizedBox(width: 6),
                _ttsButton('🔊 $selectedLanguage', () => ttsService.speak(translation, selectedLanguage)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ttsButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF4A90D9).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF4A90D9).withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 13, color: Color(0xFF2C5F8A), fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class _FirstAidCard extends StatefulWidget {
  final FirstAidStep step;
  final String selectedLanguage;
  final TtsService ttsService;

  const _FirstAidCard({
    required this.step,
    required this.selectedLanguage,
    required this.ttsService,
  });

  @override
  State<_FirstAidCard> createState() => _FirstAidCardState();
}

class _FirstAidCardState extends State<_FirstAidCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final translatedTitle = widget.step.getTitle(widget.selectedLanguage);
    final translatedSteps = widget.step.getSteps(widget.selectedLanguage);
    final isTranslated = widget.selectedLanguage != 'English';

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.healing, color: Colors.red.shade600, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.step.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        if (isTranslated) ...[
                          const SizedBox(height: 2),
                          Text(
                            translatedTitle,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF2C5F8A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Read All Aloud button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        _readAloudButton(
                          '🔊 Read All — English',
                          () => widget.ttsService.speak(
                            widget.step.steps.join('. '),
                            'English',
                          ),
                        ),
                        if (isTranslated) ...[
                          const SizedBox(width: 6),
                          _readAloudButton(
                            '🔊 Read All — ${widget.selectedLanguage}',
                            () => widget.ttsService.speak(
                              translatedSteps.join('. '),
                              widget.selectedLanguage,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Steps
                  ...translatedSteps.asMap().entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2C5F8A),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                '${e.key + 1}',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // English step (small, above)
                                if (isTranslated)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      widget.step.steps[e.key],
                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                                    ),
                                  ),
                                // Translated step (or English if no translation)
                                Text(
                                  e.value,
                                  style: const TextStyle(fontSize: 15, color: Color(0xFF1A1A2E), height: 1.4),
                                ),
                              ],
                            ),
                          ),
                          // Per-step TTS button
                          GestureDetector(
                            onTap: () => widget.ttsService.speak(
                              e.value,
                              isTranslated ? widget.selectedLanguage : 'English',
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6, top: 2),
                              child: Icon(
                                Icons.volume_up,
                                size: 20,
                                color: const Color(0xFF4A90D9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _readAloudButton(String label, VoidCallback onTap) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade300),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.orange.shade800, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
