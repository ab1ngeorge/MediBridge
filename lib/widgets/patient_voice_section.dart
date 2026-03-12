import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/speech_service.dart';
import '../services/translation_service.dart';
import '../services/tts_service.dart';
import 'section_card.dart';

/// Patient voice section: patient speaks in their own language,
/// speech is recognized, and translated to English for the doctor.
/// Enhanced with copy and clear functionality.
class PatientVoiceSection extends StatefulWidget {
  final String selectedLanguage;

  const PatientVoiceSection({
    super.key,
    required this.selectedLanguage,
  });

  @override
  State<PatientVoiceSection> createState() => _PatientVoiceSectionState();
}

class _PatientVoiceSectionState extends State<PatientVoiceSection> {
  final SpeechService _speechService = SpeechService();
  final TtsService _ttsService = TtsService();

  bool _isListening = false;
  bool _isTranslating = false;
  String _recognizedText = '';
  String _translatedText = '';

  String get _speechLocale =>
      TranslationService.speechLocaleCodes[widget.selectedLanguage] ?? 'en_US';

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _speechService.stopListening();
      setState(() => _isListening = false);

      if (_recognizedText.isNotEmpty) {
        _translateToEnglish();
      }
    } else {
      setState(() {
        _recognizedText = '';
        _translatedText = '';
      });

      await _speechService.startListening(
        localeId: _speechLocale,
        onResult: (text, isFinal) {
          setState(() => _recognizedText = text);
          if (isFinal) {
            setState(() => _isListening = false);
            _translateToEnglish();
          }
        },
      );
      setState(() => _isListening = true);
    }
  }

  Future<void> _translateToEnglish() async {
    if (_recognizedText.isEmpty) return;
    setState(() => _isTranslating = true);

    final result = await TranslationService.translateToEnglish(
      _recognizedText,
      widget.selectedLanguage,
    );

    if (!mounted) return;
    setState(() {
      _translatedText = result;
      _isTranslating = false;
    });
  }

  Future<void> _playVoice() async {
    if (_translatedText.isEmpty) return;
    await _ttsService.speak(_translatedText, 'English');
  }

  void _copyToClipboard() {
    if (_translatedText.isEmpty) return;
    Clipboard.setData(ClipboardData(text: _translatedText));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('English translation copied!'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _clearAll() {
    setState(() {
      _recognizedText = '';
      _translatedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Patient Voice → English',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Info banner
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF5D4037), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Patient speaks in ${widget.selectedLanguage} → Doctor reads in English',
                    style: const TextStyle(fontSize: 15, color: Color(0xFF5D4037)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Record button
          SizedBox(
            height: 60,
            child: ElevatedButton.icon(
              onPressed: _isTranslating ? null : _toggleListening,
              icon: Icon(
                _isListening ? Icons.stop_circle : Icons.mic,
                size: 30,
              ),
              label: Text(
                _isListening ? 'Stop Recording' : '🎤  Patient — Tap to Speak',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isListening ? Colors.red.shade600 : Colors.teal.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Listening indicator
          if (_isListening)
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.hearing, color: Colors.red, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Listening in ${widget.selectedLanguage}...',
                    style: const TextStyle(fontSize: 17, color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

          // Recognized text
          if (_recognizedText.isNotEmpty) ...[
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.selectedLanguage} Text:',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
                GestureDetector(
                  onTap: _clearAll,
                  child: const Row(
                    children: [
                      Icon(Icons.clear, size: 16, color: Colors.grey),
                      SizedBox(width: 2),
                      Text('Clear', style: TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SelectableText(
                _recognizedText,
                style: const TextStyle(fontSize: 18, color: Color(0xFF1A1A2E)),
              ),
            ),
          ],

          // Loading
          if (_isTranslating)
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5)),
                  SizedBox(width: 12),
                  Text('Translating to English...', style: TextStyle(fontSize: 16, color: Color(0xFF00695C))),
                ],
              ),
            ),

          // English translation
          if (_translatedText.isNotEmpty && !_isTranslating) ...[
            const SizedBox(height: 14),
            const Text(
              'English Translation (for Doctor):',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: SelectableText(
                _translatedText,
                style: const TextStyle(fontSize: 20, color: Color(0xFF1A1A2E), height: 1.5),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _playVoice,
                      icon: const Icon(Icons.volume_up, size: 22),
                      label: const Text('Play English', style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _copyToClipboard,
                    icon: const Icon(Icons.copy, size: 20),
                    label: const Text('Copy', style: TextStyle(fontSize: 15)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.teal.shade700,
                      side: BorderSide(color: Colors.teal.shade700),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
