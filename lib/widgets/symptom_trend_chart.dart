import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/outbreak_service.dart';

/// Bar chart showing symptom frequency trends.
/// Uses fl_chart for visual display.
class SymptomTrendChart extends StatelessWidget {
  const SymptomTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    final frequencies = OutbreakService.getSymptomFrequencies();

    if (frequencies.isEmpty) {
      return const SizedBox.shrink();
    }

    // Take top 6 symptoms
    final topSymptoms = frequencies.entries.take(6).toList();
    final maxValue = topSymptoms.first.value.toDouble();

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
                  Icon(Icons.bar_chart, color: Color(0xFF2C5F8A), size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Symptom Trends',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxValue + 2,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${topSymptoms[groupIndex].key}\n${rod.toY.toInt()} reports',
                            const TextStyle(color: Colors.white, fontSize: 12),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < topSymptoms.length) {
                              // Truncate long labels
                              final label = topSymptoms[index].key;
                              final short = label.length > 7
                                  ? '${label.substring(0, 6)}.'
                                  : label;
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  short,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                          reservedSize: 28,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: maxValue > 4 ? (maxValue / 4).ceilToDouble() : 1,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.shade200,
                        strokeWidth: 1,
                      ),
                    ),
                    barGroups: topSymptoms.asMap().entries.map((entry) {
                      final index = entry.key;
                      final count = entry.value.value.toDouble();
                      final isHighest = index == 0;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: count,
                            width: 22,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: isHighest
                                  ? [Colors.red.shade400, Colors.red.shade600]
                                  : [const Color(0xFF4A90D9), const Color(0xFF2C5F8A)],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
