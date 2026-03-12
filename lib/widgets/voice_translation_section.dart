import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/speech_service.dart';
import '../services/translation_service.dart';
import '../services/tts_service.dart';
import 'section_card.dart';

/// Voice translation section: records doctor's speech, converts to text,
/// translates via AI, and provides voice playback.
/// Enhanced with copy-to-clipboard and better loading states.
class VoiceTranslationSection extends StatefulWidget {
  final String selectedLanguage;

  const VoiceTranslationSection({
    super.key,
    required this.selectedLanguage,
  });

  @override
  State<VoiceTranslationSection> createState() =>
      _VoiceTranslationSectionState();
}

class _VoiceTranslationSectionState extends State<VoiceTranslationSection> {
  final SpeechService _speechService = SpeechService();
  final TtsService _ttsService = TtsService();

  bool _isListening = false;
  bool _isTranslating = false;
  String _recognizedText = '';
  String _translatedText = '';

  /// Toggle voice recording on/off.
  Future<void> _toggleListening() async {
    if (_isListening) {
      await _speechService.stopListening();
      setState(() => _isListening = false);

      if (_recognizedText.isNotEmpty) {
        _translateText();
      }
    } else {
      setState(() {
        _recognizedText = '';
        _translatedText = '';
      });

      await _speechService.startListening(
        onResult: (text, isFinal) {
          setState(() => _recognizedText = text);
          if (isFinal) {
            setState(() => _isListening = false);
            _translateText();
          }
        },
      );
      setState(() => _isListening = true);
    }
  }

  Future<void> _translateText() async {
    if (_recognizedText.isEmpty) return;
    setState(() => _isTranslating = true);

    final result = await TranslationService.translateInstruction(
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
    await _ttsService.speak(_translatedText, widget.selectedLanguage);
  }

  void _copyToClipboard() {
    if (_translatedText.isEmpty) return;
    Clipboard.setData(ClipboardData(text: _translatedText));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Translated text copied!'),
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
      title: 'Doctor Voice → ${widget.selectedLanguage}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                _isListening ? 'Stop Recording' : '🎤  Tap to Speak',
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isListening ? Colors.red.shade600 : const Color(0xFF4A90D9),
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
              child: const Row(
                children: [
                  Icon(Icons.hearing, color: Colors.red, size: 22),
                  SizedBox(width: 10),
                  Text(
                    'Listening... Speak now',
                    style: TextStyle(fontSize: 17, color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

          // Recognized text
          if (_recognizedText.isNotEmpty) ...[
            const SizedBox(height: 14),
            _labelRow('Recognized English Text:', onClear: _clearAll),
            const SizedBox(height: 4),
            _resultBox(_recognizedText, Colors.grey.shade100, null),
          ],

          // Loading
          if (_isTranslating)
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5)),
                  SizedBox(width: 12),
                  Text('Translating... please wait', style: TextStyle(fontSize: 16, color: Color(0xFF2C5F8A))),
                ],
              ),
            ),

          // Translated text
          if (_translatedText.isNotEmpty && !_isTranslating) ...[
            const SizedBox(height: 14),
            const _SectionLabel('Translated Text:'),
            const SizedBox(height: 4),
            _resultBox(_translatedText, const Color(0xFFE8F4FD), const Color(0xFF4A90D9)),
            const SizedBox(height: 10),
            // Action buttons row
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _playVoice,
                      icon: const Icon(Icons.volume_up, size: 22),
                      label: const Text('Play Voice', style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A90D9),
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
                      foregroundColor: const Color(0xFF4A90D9),
                      side: const BorderSide(color: Color(0xFF4A90D9)),
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

  Widget _labelRow(String text, {VoidCallback? onClear}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SectionLabel(text),
        if (onClear != null)
          GestureDetector(
            onTap: onClear,
            child: const Row(
              children: [
                Icon(Icons.clear, size: 16, color: Colors.grey),
                SizedBox(width: 2),
                Text('Clear', style: TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _resultBox(String text, Color bgColor, Color? borderColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: borderColor != null ? Border.all(color: borderColor.withValues(alpha: 0.3)) : null,
      ),
      child: SelectableText(
        text,
        style: const TextStyle(fontSize: 20, color: Color(0xFF1A1A2E), height: 1.5),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
    );
  }
}
