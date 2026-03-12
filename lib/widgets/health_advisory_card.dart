import 'package:flutter/material.dart';
import '../services/health_data_service.dart';

/// Shows seasonal health advisories from real-world data sources.
class HealthAdvisoryCard extends StatelessWidget {
  const HealthAdvisoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final advisories = HealthDataService.getSeasonalAdvisories();

    if (advisories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.public, color: Color(0xFF2C5F8A), size: 22),
              SizedBox(width: 8),
              Text(
                'Health Advisories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ),

        ...advisories.map((advisory) => _AdvisoryItem(advisory: advisory)),
      ],
    );
  }
}

class _AdvisoryItem extends StatefulWidget {
  final HealthAdvisory advisory;

  const _AdvisoryItem({required this.advisory});

  @override
  State<_AdvisoryItem> createState() => _AdvisoryItemState();
}

class _AdvisoryItemState extends State<_AdvisoryItem> {
  bool _expanded = false;

  Color get _severityColor {
    switch (widget.advisory.severity) {
      case 'HIGH': return Colors.red;
      case 'MODERATE': return Colors.orange;
      case 'INFO': return Colors.blue;
      default: return Colors.green;
    }
  }

  Color get _bgColor {
    switch (widget.advisory.severity) {
      case 'HIGH': return Colors.red.shade50;
      case 'MODERATE': return Colors.orange.shade50;
      case 'INFO': return Colors.blue.shade50;
      default: return Colors.green.shade50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: _severityColor.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _severityColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.advisory.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Source: ${widget.advisory.source}',
                            style: const TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _bgColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.advisory.severity,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _severityColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 22),
                    ),
                  ],
                ),
              ),
            ),
            if (_expanded)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(26, 0, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.advisory.description,
                      style: const TextStyle(fontSize: 14, color: Color(0xFF333333), height: 1.5),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: widget.advisory.diseases.map((d) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _bgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            d,
                            style: TextStyle(fontSize: 12, color: _severityColor, fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
