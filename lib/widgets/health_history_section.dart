import 'package:flutter/material.dart';
import '../services/health_history_service.dart';
import '../services/app_localizations.dart';

/// Health history timeline section.
/// Shows past symptom entries with risk levels and AI summaries.
class HealthHistorySection extends StatefulWidget {
  const HealthHistorySection({super.key});

  @override
  State<HealthHistorySection> createState() => _HealthHistorySectionState();
}

class _HealthHistorySectionState extends State<HealthHistorySection> {
  List<HealthEntry> _entries = [];
  Map<String, int> _recurring = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final entries = await HealthHistoryService.getAllEntries();
    final recurring = await HealthHistoryService.getRecurringSymptoms();
    if (!mounted) return;
    setState(() {
      _entries = entries;
      _recurring = recurring;
      _isLoading = false;
    });
  }

  Future<void> _clearHistory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.get('clearHistoryTitle')),
        content: Text(AppLocalizations.get('clearHistoryMsg')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(AppLocalizations.get('cancel'))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(AppLocalizations.get('clearHistory'), style: TextStyle(color: Colors.red.shade600)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await HealthHistoryService.clearHistory();
      _loadHistory();
    }
  }

  Color _riskColor(String level) {
    switch (level) {
      case 'EMERGENCY': return Colors.red;
      case 'HIGH': return Colors.orange;
      case 'MODERATE': return Colors.amber.shade700;
      default: return Colors.green;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.history, color: Color(0xFF2C5F8A), size: 24),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Health History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ),
                if (_entries.isNotEmpty)
                  TextButton.icon(
                    onPressed: _clearHistory,
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: Text(AppLocalizations.get('clearHistory')),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
              ],
            ),
          ),

          // Recurring symptoms alert
          if (_recurring.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                elevation: 0,
                color: Colors.orange.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.orange.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.repeat, color: Colors.orange.shade800, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.get('recurringSymptoms'),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: _recurring.entries.map((e) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${e.key} (${e.value}x)',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange.shade900,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        AppLocalizations.get('recurringWarning'),
                        style: TextStyle(fontSize: 13, color: Colors.orange.shade800),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Empty state
          if (_entries.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  const Text(
                    'No health records yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppLocalizations.get('noHistoryDesc'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

          // Timeline entries
          ..._entries.asMap().entries.map((mapEntry) {
            final index = mapEntry.key;
            final entry = mapEntry.value;
            return _TimelineEntry(
              entry: entry,
              riskColor: _riskColor(entry.riskLevel),
              dateLabel: _formatDate(entry.date),
              isLast: index == _entries.length - 1,
            );
          }),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatefulWidget {
  final HealthEntry entry;
  final Color riskColor;
  final String dateLabel;
  final bool isLast;

  const _TimelineEntry({
    required this.entry,
    required this.riskColor,
    required this.dateLabel,
    required this.isLast,
  });

  @override
  State<_TimelineEntry> createState() => _TimelineEntryState();
}

class _TimelineEntryState extends State<_TimelineEntry> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline line + dot
            SizedBox(
              width: 30,
              child: Column(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: widget.riskColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.riskColor.withValues(alpha: 0.4), width: 3),
                    ),
                  ),
                  if (!widget.isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Entry card
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Card(
                  elevation: 1,
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: widget.riskColor.withValues(alpha: 0.3)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date + risk
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.dateLabel,
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: widget.riskColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                widget.entry.riskLevel,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: widget.riskColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Symptoms chips
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: widget.entry.symptoms.map((s) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(s, style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                        ),

                        if (widget.entry.summary.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            widget.entry.summary,
                            maxLines: _expanded ? null : 2,
                            overflow: _expanded ? null : TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.4),
                          ),
                        ],

                        if (!_expanded && widget.entry.fullAnalysis != null)
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              AppLocalizations.get('tapFullAnalysis'),
                              style: TextStyle(fontSize: 12, color: Color(0xFF4A90D9)),
                            ),
                          ),

                        if (_expanded && widget.entry.fullAnalysis != null) ...[
                          const Divider(height: 16),
                          Text(
                            widget.entry.fullAnalysis!,
                            style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E), height: 1.5),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
