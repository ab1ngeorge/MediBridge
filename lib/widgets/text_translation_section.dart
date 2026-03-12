import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/translation_service.dart';
import '../services/tts_service.dart';
import 'section_card.dart';

/// Common medical phrases for quick selection.
const List<String> _quickPhrases = [
  'Take this tablet twice daily after meals',
  'Apply this ointment on the affected area',
  'Drink plenty of water and rest',
  'Come for a follow-up after 5 days',
  'Take this medicine before bed',
  'Do not eat spicy food for 3 days',
  'Take this syrup 3 times a day',
  'You need a blood test tomorrow morning',
];

/// Text input section with quick phrases, copy, and clear.
class TextTranslationSection extends StatefulWidget {
  final String selectedLanguage;

  const TextTranslationSection({
    super.key,
    required this.selectedLanguage,
  });

  @override
  State<TextTranslationSection> createState() => _TextTranslationSectionState();
}

class _TextTranslationSectionState extends State<TextTranslationSection> {
  final TextEditingController _textController = TextEditingController();
  final TtsService _ttsService = TtsService();

  bool _isTranslating = false;
  String _translatedText = '';

  Future<void> _translate() async {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please type or select an instruction first'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isTranslating = true);

    final result = await TranslationService.translateInstruction(
      text,
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
    _textController.clear();
    setState(() => _translatedText = '');
  }

  void _useQuickPhrase(String phrase) {
    _textController.text = phrase;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Type Medical Instruction',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Quick phrases
          const Text(
            'Quick Phrases — tap to use:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _quickPhrases.map((phrase) {
              return GestureDetector(
                onTap: () => _useQuickPhrase(phrase),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF4A90D9).withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    phrase,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF1565C0)),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),

          // Text input with clear button
          TextField(
            controller: _textController,
            maxLines: 3,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Type instruction or tap a quick phrase above...',
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF4A90D9), width: 2),
              ),
              contentPadding: const EdgeInsets.all(14),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: _clearAll,
                tooltip: 'Clear',
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Translate button
          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _isTranslating ? null : _translate,
              icon: const Icon(Icons.translate, size: 24),
              label: Text(
                _isTranslating ? 'Translating...' : 'Translate',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90D9),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          // Loading
          if (_isTranslating)
            Container(
              margin: const EdgeInsets.only(top: 14),
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

          // Translated output
          if (_translatedText.isNotEmpty && !_isTranslating) ...[
            const SizedBox(height: 14),
            const Text(
              'Translated Output:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F4FD),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF4A90D9).withValues(alpha: 0.3)),
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
}
