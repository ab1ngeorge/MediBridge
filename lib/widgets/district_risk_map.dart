import 'package:flutter/material.dart';
import '../services/outbreak_service.dart';

/// Grid-based Kerala district risk heatmap.
/// Colors districts based on the number of symptom reports.
class DistrictRiskMap extends StatelessWidget {
  const DistrictRiskMap({super.key});

  @override
  Widget build(BuildContext context) {
    final locationCounts = OutbreakService.getLocationCounts();

    if (locationCounts.isEmpty) {
      return const SizedBox.shrink();
    }

    final maxCount = locationCounts.values.fold(0, (a, b) => a > b ? a : b);

    return Padding(
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
                  Icon(Icons.map, color: Color(0xFF2C5F8A), size: 22),
                  SizedBox(width: 8),
                  Text(
                    'District Risk Heatmap',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Kerala districts colored by report density',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),

              // Legend
              Row(
                children: [
                  _legendItem('Low', Colors.green.shade300),
                  const SizedBox(width: 12),
                  _legendItem('Medium', Colors.yellow.shade700),
                  const SizedBox(width: 12),
                  _legendItem('High', Colors.orange),
                  const SizedBox(width: 12),
                  _legendItem('Critical', Colors.red),
                ],
              ),
              const SizedBox(height: 12),

              // District grid
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: OutbreakService.keralaDistricts.map((district) {
                  final count = locationCounts[district] ?? 0;
                  final color = _getRiskColor(count, maxCount);
                  final textColor = count > 0 ? Colors.white : const Color(0xFF1A1A2E);

                  return Container(
                    width: (MediaQuery.of(context).size.width - 62) / 3,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    decoration: BoxDecoration(
                      color: count > 0 ? color : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: count > 0 ? color.withValues(alpha: 0.7) : Colors.grey.shade300,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          district,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (count > 0) ...[
                          const SizedBox(height: 2),
                          Text(
                            '$count',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRiskColor(int count, int maxCount) {
    if (count == 0) return Colors.grey.shade100;
    final ratio = count / maxCount;
    if (ratio >= 0.75) return Colors.red;
    if (ratio >= 0.5) return Colors.orange;
    if (ratio >= 0.25) return Colors.yellow.shade700;
    return Colors.green.shade400;
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
