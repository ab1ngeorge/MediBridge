import 'package:flutter/material.dart';

/// Color-coded risk level indicator widget.
/// Parses the AI analysis text and shows the appropriate risk level.
class RiskLevelIndicator extends StatelessWidget {
  final String riskLevel;

  const RiskLevelIndicator({super.key, required this.riskLevel});

  /// Parse risk level from AI analysis text.
  static String parseFromAnalysis(String analysisText) {
    final text = analysisText.toUpperCase();
    if (text.contains('RISK LEVEL: EMERGENCY') || text.contains('🚨 EMERGENCY')) {
      return 'EMERGENCY';
    } else if (text.contains('RISK LEVEL: HIGH')) {
      return 'HIGH';
    } else if (text.contains('RISK LEVEL: MODERATE')) {
      return 'MODERATE';
    }
    return 'LOW';
  }

  Color get _color {
    switch (riskLevel) {
      case 'EMERGENCY':
        return Colors.red;
      case 'HIGH':
        return Colors.orange;
      case 'MODERATE':
        return Colors.amber.shade700;
      case 'LOW':
      default:
        return Colors.green;
    }
  }

  Color get _bgColor {
    switch (riskLevel) {
      case 'EMERGENCY':
        return Colors.red.shade50;
      case 'HIGH':
        return Colors.orange.shade50;
      case 'MODERATE':
        return Colors.amber.shade50;
      case 'LOW':
      default:
        return Colors.green.shade50;
    }
  }

  IconData get _icon {
    switch (riskLevel) {
      case 'EMERGENCY':
        return Icons.warning_rounded;
      case 'HIGH':
        return Icons.error_outline;
      case 'MODERATE':
        return Icons.info_outline;
      case 'LOW':
      default:
        return Icons.check_circle_outline;
    }
  }

  String get _label {
    switch (riskLevel) {
      case 'EMERGENCY':
        return '🔴 EMERGENCY — Go to hospital immediately';
      case 'HIGH':
        return '🟠 HIGH RISK — Seek medical care today';
      case 'MODERATE':
        return '🟡 MODERATE — Visit a clinic soon';
      case 'LOW':
      default:
        return '🟢 LOW RISK — Monitor symptoms at home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _color.withValues(alpha: 0.4), width: 2),
      ),
      child: Row(
        children: [
          Icon(_icon, color: _color, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RISK LEVEL',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _color,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _color,
                  ),
                ),
              ],
            ),
          ),
          // Risk level dots
          Row(
            children: [
              _dot(Colors.green, riskLevel == 'LOW' || riskLevel == 'MODERATE' || riskLevel == 'HIGH' || riskLevel == 'EMERGENCY'),
              const SizedBox(width: 3),
              _dot(Colors.amber.shade700, riskLevel == 'MODERATE' || riskLevel == 'HIGH' || riskLevel == 'EMERGENCY'),
              const SizedBox(width: 3),
              _dot(Colors.orange, riskLevel == 'HIGH' || riskLevel == 'EMERGENCY'),
              const SizedBox(width: 3),
              _dot(Colors.red, riskLevel == 'EMERGENCY'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color, bool active) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? color : Colors.grey.shade300,
        border: active ? Border.all(color: color.withValues(alpha: 0.5), width: 2) : null,
      ),
    );
  }
}
