import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/translation_service.dart';
import '../services/tts_service.dart';
import 'section_card.dart';

/// Prescription explanation section with copy, clear, and enhanced UX.
class PrescriptionSection extends StatefulWidget {
  final String selectedLanguage;

  const PrescriptionSection({
    super.key,
    required this.selectedLanguage,
  });

  @override
  State<PrescriptionSection> createState() => _PrescriptionSectionState();
}

class _PrescriptionSectionState extends State<PrescriptionSection> {
  final TextEditingController _prescriptionController = TextEditingController();
  final TtsService _ttsService = TtsService();

  bool _isLoading = false;
  String _explanation = '';

  Future<void> _generateExplanation() async {
    final text = _prescriptionController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a prescription first'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await TranslationService.explainPrescription(
      text,
      widget.selectedLanguage,
    );

    if (!mounted) return;
    setState(() {
      _explanation = result;
      _isLoading = false;
    });
  }

  Future<void> _playVoice() async {
    if (_explanation.isEmpty) return;
    await _ttsService.speak(_explanation, widget.selectedLanguage);
  }

  void _copyToClipboard() {
    if (_explanation.isEmpty) return;
    Clipboard.setData(ClipboardData(text: _explanation));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Explanation copied!'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _clearAll() {
    _prescriptionController.clear();
    setState(() => _explanation = '');
  }

  @override
  void dispose() {
    _prescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Explain Prescription',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hint banner
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.purple.shade100),
            ),
            child: const Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Color(0xFF6A1B9A), size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Paste a prescription → Get a simple explanation the patient can understand',
                    style: TextStyle(fontSize: 14, color: Color(0xFF4A148C)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Prescription input
          TextField(
            controller: _prescriptionController,
            maxLines: 4,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: 'e.g., Paracetamol 500mg twice daily for fever\nAmoxicillin 250mg thrice daily for 5 days',
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
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

          // Generate button
          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _generateExplanation,
              icon: const Icon(Icons.auto_awesome, size: 24),
              label: Text(
                _isLoading ? 'Generating...' : 'Generate Explanation',
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
          if (_isLoading)
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
                  Text('Generating explanation...', style: TextStyle(fontSize: 16, color: Color(0xFF2C5F8A))),
                ],
              ),
            ),

          // Explanation output
          if (_explanation.isNotEmpty && !_isLoading) ...[
            const SizedBox(height: 14),
            const Text(
              'Simple Explanation:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F8E8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: SelectableText(
                _explanation,
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
