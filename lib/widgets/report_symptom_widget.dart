import 'package:flutter/material.dart';
import '../services/outbreak_service.dart';

/// Anonymous symptom reporting widget.
/// Users select symptoms, location, and submit without providing identity.
class ReportSymptomWidget extends StatefulWidget {
  final VoidCallback onReportSubmitted;

  const ReportSymptomWidget({
    super.key,
    required this.onReportSubmitted,
  });

  @override
  State<ReportSymptomWidget> createState() => _ReportSymptomWidgetState();
}

class _ReportSymptomWidgetState extends State<ReportSymptomWidget> {
  final List<String> _selectedSymptoms = [];
  String _selectedLocation = 'Kasaragod';
  final TextEditingController _notesController = TextEditingController();
  bool _submitted = false;

  void _toggleSymptom(String symptom) {
    setState(() {
      if (_selectedSymptoms.contains(symptom)) {
        _selectedSymptoms.remove(symptom);
      } else {
        _selectedSymptoms.add(symptom);
      }
    });
  }

  void _submitReport() {
    if (_selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one symptom'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    OutbreakService.submitReport(SymptomReport(
      symptoms: List.from(_selectedSymptoms),
      location: _selectedLocation,
      timestamp: DateTime.now(),
      additionalNotes: _notesController.text.trim().isNotEmpty
          ? _notesController.text.trim()
          : null,
    ));

    setState(() => _submitted = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Report submitted anonymously. Thank you!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    );

    widget.onReportSubmitted();

    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _selectedSymptoms.clear();
          _notesController.clear();
          _submitted = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Row(
              children: [
                Icon(Icons.add_circle_outline, color: Color(0xFF2C5F8A), size: 24),
                SizedBox(width: 8),
                Text(
                  'Report Symptoms',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.shield, color: Color(0xFF2E7D32), size: 18),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Anonymous — No personal data collected',
                      style: TextStyle(fontSize: 13, color: Color(0xFF1B5E20), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Location selector
            const Text('Your Area:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF4A90D9)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedLocation,
                  isExpanded: true,
                  style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A2E)),
                  items: OutbreakService.keralaDistricts.map((d) {
                    return DropdownMenuItem(value: d, child: Text(d));
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedLocation = v);
                  },
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Symptoms
            const Text('Select Symptoms:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: OutbreakService.reportableSymptoms.map((symptom) {
                final isSelected = _selectedSymptoms.contains(symptom);
                return GestureDetector(
                  onTap: () => _toggleSymptom(symptom),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF4A90D9) : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF4A90D9) : Colors.grey.shade400,
                      ),
                    ),
                    child: Text(
                      isSelected ? '✓ $symptom' : symptom,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.white : const Color(0xFF1A1A2E),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            // Additional notes
            TextField(
              controller: _notesController,
              maxLines: 2,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Additional details (optional)',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.all(12),
                isDense: true,
              ),
            ),
            const SizedBox(height: 14),

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _submitted ? null : _submitReport,
                icon: Icon(_submitted ? Icons.check : Icons.send, size: 22),
                label: Text(
                  _submitted ? 'Submitted ✓' : 'Submit Report',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _submitted ? Colors.green : const Color(0xFF2C5F8A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
