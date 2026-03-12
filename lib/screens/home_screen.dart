import 'package:flutter/material.dart';
import '../services/app_localizations.dart';
import '../widgets/language_selector.dart';
import '../widgets/voice_translation_section.dart';
import '../widgets/patient_voice_section.dart';
import '../widgets/text_translation_section.dart';
import '../widgets/prescription_section.dart';
import '../widgets/health_bot_section.dart';
import '../widgets/section_card.dart';
import '../widgets/offline_emergency_screen.dart';
import '../widgets/health_history_section.dart';
import 'early_warning_screen.dart';

/// Main screen of MediBridge app.
/// Uses tab navigation to separate Doctor and Patient flows.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String _selectedLanguage = 'Malayalam';
  String _uiLocale = 'en';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild to show/hide language selector
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _t(String key) => AppLocalizations.get(key, locale: _uiLocale);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _t('appName'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              _t('appSubtitle'),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2C5F8A),
        toolbarHeight: 70,
        actions: [
          // UI Language toggle
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: PopupMenuButton<String>(
              onSelected: (locale) {
                setState(() => _uiLocale = locale);
                AppLocalizations.currentLocale = locale;
              },
              icon: const Icon(Icons.language, color: Colors.white),
              tooltip: 'Change UI Language',
              itemBuilder: (_) => AppLocalizations.localeNames.entries
                  .map((e) => PopupMenuItem(
                        value: e.key,
                        child: Row(
                          children: [
                            if (_uiLocale == e.key)
                              const Icon(Icons.check, size: 18, color: Color(0xFF2C5F8A)),
                            if (_uiLocale == e.key) const SizedBox(width: 8),
                            Text(e.value),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(icon: const Icon(Icons.radar, size: 20), text: _t('tabEarlyWarning')),
            Tab(icon: const Icon(Icons.medical_services, size: 20), text: _t('tabDoctor')),
            Tab(icon: const Icon(Icons.person, size: 20), text: _t('tabPatient')),
            Tab(icon: const Icon(Icons.health_and_safety, size: 20), text: _t('tabHealthBot')),
            Tab(icon: const Icon(Icons.history, size: 20), text: _t('healthHistory')),
            Tab(icon: const Icon(Icons.wifi_off, size: 20), text: _t('tabOffline')),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          // Language selector (visible on translation tabs and offline tab)
          if ((_tabController.index >= 1 && _tabController.index <= 3) || _tabController.index == 5)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: SectionCard(
                title: _t('selectLanguage'),
                child: LanguageSelector(
                  selectedLanguage: _selectedLanguage,
                  onChanged: (lang) {
                    setState(() => _selectedLanguage = lang);
                  },
                ),
              ),
            ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // === EARLY WARNING TAB ===
                const EarlyWarningScreen(),

                // === DOCTOR TAB ===
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    children: [
                      // Doctor speaks → Patient's language
                      VoiceTranslationSection(
                        key: ValueKey('voice_$_selectedLanguage'),
                        selectedLanguage: _selectedLanguage,
                      ),

                      // Type instruction → Translate
                      TextTranslationSection(
                        key: ValueKey('text_$_selectedLanguage'),
                        selectedLanguage: _selectedLanguage,
                      ),

                      // Explain prescription
                      PrescriptionSection(
                        key: ValueKey('rx_$_selectedLanguage'),
                        selectedLanguage: _selectedLanguage,
                      ),
                    ],
                  ),
                ),

                // === PATIENT TAB ===
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    children: [
                      // Patient speaks → English for doctor
                      PatientVoiceSection(
                        key: ValueKey('patient_$_selectedLanguage'),
                        selectedLanguage: _selectedLanguage,
                      ),

                      // Info card for patient
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Card(
                          elevation: 0,
                          color: const Color(0xFFF0F8E8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.green.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                const Icon(Icons.info_outline, color: Color(0xFF2E7D32), size: 32),
                                const SizedBox(height: 8),
                                Text(
                                  _t('patientInfo'),
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1B5E20),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _t('patientInfoDetail'),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16, color: Color(0xFF2E7D32), height: 1.4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // === HEALTH BOT TAB ===
                HealthBotSection(selectedLanguage: _selectedLanguage),

                // === HEALTH HISTORY TAB ===
                const HealthHistorySection(),

                // === OFFLINE EMERGENCY TAB ===
                OfflineEmergencyScreen(selectedLanguage: _selectedLanguage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
