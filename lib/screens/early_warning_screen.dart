import 'package:flutter/material.dart';
import '../services/app_localizations.dart';
import '../widgets/report_symptom_widget.dart';
import '../widgets/outbreak_dashboard.dart';
import '../widgets/doctor_feedback_section.dart';
import '../widgets/symptom_trend_chart.dart';
import '../widgets/district_risk_map.dart';
import '../widgets/health_advisory_card.dart';
import '../services/simulation_service.dart';

/// Early Warning Network screen.
/// Combines symptom reporting, outbreak dashboard, charts,
/// simulations, and health advisories in a single scrollable view.
class EarlyWarningScreen extends StatefulWidget {
  const EarlyWarningScreen({super.key});

  @override
  State<EarlyWarningScreen> createState() => _EarlyWarningScreenState();
}

class _EarlyWarningScreenState extends State<EarlyWarningScreen> {
  int _reportCount = 0;
  bool _showSimulation = false;

  String _t(String key) => AppLocalizations.get(key);

  void _onReportSubmitted() {
    setState(() => _reportCount++);
  }

  void _runSimulation(String scenarioId) {
    SimulationService.runScenario(scenarioId);
    setState(() {
      _reportCount++;
      _showSimulation = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Simulation data injected! Dashboard updated.'),
        backgroundColor: Color(0xFF2C5F8A),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              elevation: 0,
              color: const Color(0xFFFCE4EC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.red.shade200),
              ),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(Icons.radar, color: Color(0xFFC62828), size: 30),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _t('earlyWarningTitle'),
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFFB71C1C)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            _t('earlyWarningSubtitle'),
                            style: TextStyle(fontSize: 13, color: Color(0xFFC62828)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // === SIMULATION MODE (Feature 9) ===
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _showSimulation = !_showSimulation),
                icon: const Icon(Icons.science, size: 20),
                label: Text(_showSimulation ? _t('hideSimulation') : _t('simulationMode')),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.purple.shade700,
                  side: BorderSide(color: Colors.purple.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),

          if (_showSimulation)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.purple.shade200),
                ),
                color: Colors.purple.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _t('outbreakSimulation'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _t('simulationDesc'),
                        style: TextStyle(fontSize: 13, color: Colors.purple.shade700),
                      ),
                      const SizedBox(height: 10),
                      ...SimulationService.scenarios.map((scenario) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _runSimulation(scenario.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple.shade600,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Row(
                                  children: [
                                    Text(scenario.icon, style: const TextStyle(fontSize: 20)),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(scenario.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                          Text(scenario.description, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),

          // Symptom reporting
          ReportSymptomWidget(onReportSubmitted: _onReportSubmitted),

          const SizedBox(height: 8),

          // Dashboard header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                Icon(Icons.dashboard, color: Color(0xFF2C5F8A), size: 22),
                SizedBox(width: 8),
                Text(
                  _t('outbreakDashboard'),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                ),
              ],
            ),
          ),

          // Dashboard
          OutbreakDashboard(reportCount: _reportCount),

          const SizedBox(height: 8),

          // === CHARTS (Feature 5) ===
          const SymptomTrendChart(),
          const DistrictRiskMap(),

          const SizedBox(height: 8),

          // === HEALTH ADVISORIES (Feature 10) ===
          const HealthAdvisoryCard(),

          const SizedBox(height: 8),

          // Doctor Feedback
          const DoctorFeedbackSection(),
        ],
      ),
    );
  }
}
