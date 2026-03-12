import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/outbreak_service.dart';

/// Dashboard showing outbreak analysis, stats, and AI-generated alerts.
class OutbreakDashboard extends StatefulWidget {
  /// Key that changes when new reports are submitted, triggering rebuild.
  final int reportCount;

  const OutbreakDashboard({super.key, required this.reportCount});

  @override
  State<OutbreakDashboard> createState() => _OutbreakDashboardState();
}

class _OutbreakDashboardState extends State<OutbreakDashboard> {
  bool _isAnalyzing = false;
  String _analysisResult = '';

  Future<void> _runAnalysis() async {
    setState(() {
      _isAnalyzing = true;
      _analysisResult = '';
    });

    final result = await OutbreakService.runPatternAnalysis();

    if (!mounted) return;
    setState(() {
      _analysisResult = result;
      _isAnalyzing = false;
    });
  }

  void _loadDemoData() {
    OutbreakService.addDemoData();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Demo data loaded (8 reports + 2 pharmacy signals)'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    setState(() {}); // Refresh
  }

  void _copyAnalysis() {
    if (_analysisResult.isEmpty) return;
    Clipboard.setData(ClipboardData(text: _analysisResult));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Analysis copied!'), behavior: SnackBarBehavior.floating),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final symptomFreq = OutbreakService.getSymptomFrequencies();
    final locationCounts = OutbreakService.getLocationCounts();
    final totalReports = OutbreakService.totalReports;
    final recentCount = OutbreakService.recentReports.length;

    return Column(
      children: [
        // Stats row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              _StatCard(
                icon: Icons.description,
                label: 'Total\nReports',
                value: '$totalReports',
                color: const Color(0xFF2C5F8A),
              ),
              const SizedBox(width: 8),
              _StatCard(
                icon: Icons.access_time,
                label: 'Last\n7 Days',
                value: '$recentCount',
                color: Colors.orange.shade700,
              ),
              const SizedBox(width: 8),
              _StatCard(
                icon: Icons.location_on,
                label: 'Areas\nAffected',
                value: '${locationCounts.length}',
                color: Colors.red.shade600,
              ),
            ],
          ),
        ),

        // Top symptoms
        if (symptomFreq.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.trending_up, color: Color(0xFFE65100), size: 22),
                        SizedBox(width: 8),
                        Text('Top Reported Symptoms', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...symptomFreq.entries.take(5).map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(e.key, style: const TextStyle(fontSize: 15)),
                              ),
                              Expanded(
                                flex: 5,
                                child: LinearProgressIndicator(
                                  value: e.value / (symptomFreq.values.first),
                                  backgroundColor: Colors.grey.shade200,
                                  color: e.value == symptomFreq.values.first
                                      ? Colors.red
                                      : const Color(0xFF4A90D9),
                                  minHeight: 10,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text('${e.value}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),

        // Location breakdown
        if (locationCounts.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.map, color: Color(0xFF2E7D32), size: 22),
                        SizedBox(width: 8),
                        Text('Reports by Location', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...locationCounts.entries.map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Expanded(child: Text(e.key, style: const TextStyle(fontSize: 15))),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: e.value >= 3 ? Colors.red.shade100 : Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${e.value} reports',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: e.value >= 3 ? Colors.red.shade800 : const Color(0xFF2C5F8A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),

        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: _isAnalyzing || totalReports == 0 ? null : _runAnalysis,
                    icon: Icon(_isAnalyzing ? Icons.hourglass_top : Icons.analytics, size: 22),
                    label: Text(
                      _isAnalyzing ? 'Analyzing...' : '🔍 Run AI Analysis',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C5F8A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: _loadDemoData,
                  icon: const Icon(Icons.science, size: 20),
                  label: const Text('Demo', style: TextStyle(fontSize: 14)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2C5F8A),
                    side: const BorderSide(color: Color(0xFF2C5F8A)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Loading state
        if (_isAnalyzing)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 0,
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 12),
                    Text(
                      'Running AI Pattern Analysis...',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFF2C5F8A)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Analyzing symptom clusters, geographic patterns, and time trends',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Color(0xFF5C6BC0)),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Analysis result
        if (_analysisResult.isNotEmpty && !_isAnalyzing)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: _analysisResult.contains('RED')
                      ? Colors.red.shade300
                      : _analysisResult.contains('ORANGE')
                          ? Colors.orange.shade300
                          : Colors.green.shade300,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _analysisResult.contains('RED') || _analysisResult.contains('ORANGE')
                              ? Icons.warning_amber
                              : Icons.check_circle,
                          color: _analysisResult.contains('RED')
                              ? Colors.red
                              : _analysisResult.contains('ORANGE')
                                  ? Colors.orange
                                  : Colors.green,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'AI Outbreak Analysis',
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    SelectableText(
                      _analysisResult,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A2E), height: 1.6),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: OutlinedButton.icon(
                        onPressed: _copyAnalysis,
                        icon: const Icon(Icons.copy, size: 18),
                        label: const Text('Copy Full Analysis', style: TextStyle(fontSize: 14)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2C5F8A),
                          side: const BorderSide(color: Color(0xFF2C5F8A)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Small stat card widget.
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
