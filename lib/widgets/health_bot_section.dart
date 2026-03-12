import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/health_bot_service.dart';
import '../services/speech_service.dart';
import '../services/tts_service.dart';
import '../services/translation_service.dart';
import '../services/hospital_finder_service.dart';
import '../services/health_history_service.dart';
import '../services/app_localizations.dart';
import 'risk_level_indicator.dart';
import 'emergency_hospital_sheet.dart';

/// Common symptom chips for quick selection.
const List<String> _commonSymptoms = [
  'Fever',
  'Headache',
  'Cough',
  'Body pain',
  'Stomach pain',
  'Skin rash',
  'Vomiting',
  'Diarrhea',
  'Sore throat',
  'Fatigue',
  'Chest pain',
  'Difficulty breathing',
];

/// Translated symptom labels for each supported language.
const Map<String, Map<String, String>> _symptomTranslations = {
  'Malayalam': {
    'Fever': 'പനി', 'Headache': 'തലവേദന', 'Cough': 'ചുമ',
    'Body pain': 'ശരീരവേദന', 'Stomach pain': 'വയറുവേദന',
    'Skin rash': 'ചർമ്മ ചൊറിച്ചിൽ', 'Vomiting': 'ഛർദ്ദി',
    'Diarrhea': 'വയറിളക്കം', 'Sore throat': 'തൊണ്ടവേദന',
    'Fatigue': 'ക്ഷീണം', 'Chest pain': 'നെഞ്ചുവേദന',
    'Difficulty breathing': 'ശ്വാസതടസ്സം',
  },
  'Hindi': {
    'Fever': 'बुखार', 'Headache': 'सिरदर्द', 'Cough': 'खांसी',
    'Body pain': 'बदन दर्द', 'Stomach pain': 'पेट दर्द',
    'Skin rash': 'त्वचा पर चकत्ते', 'Vomiting': 'उल्टी',
    'Diarrhea': 'दस्त', 'Sore throat': 'गले में खराश',
    'Fatigue': 'थकान', 'Chest pain': 'सीने में दर्द',
    'Difficulty breathing': 'सांस लेने में कठिनाई',
  },
  'Tamil': {
    'Fever': 'காய்ச்சல்', 'Headache': 'தலைவலி', 'Cough': 'இருமல்',
    'Body pain': 'உடல்வலி', 'Stomach pain': 'வயிற்று வலி',
    'Skin rash': 'தோல் அரிப்பு', 'Vomiting': 'வாந்தி',
    'Diarrhea': 'வயிற்றுப்போக்கு', 'Sore throat': 'தொண்டை வலி',
    'Fatigue': 'சோர்வு', 'Chest pain': 'நெஞ்சு வலி',
    'Difficulty breathing': 'மூச்சுத் திணறல்',
  },
  'Kannada': {
    'Fever': 'ಜ್ವರ', 'Headache': 'ತಲೆನೋವು', 'Cough': 'ಕೆಮ್ಮು',
    'Body pain': 'ಮೈಕೈ ನೋವು', 'Stomach pain': 'ಹೊಟ್ಟೆ ನೋವು',
    'Skin rash': 'ಚರ್ಮ ದದ್ದು', 'Vomiting': 'ವಾಂತಿ',
    'Diarrhea': 'ಅತಿಸಾರ', 'Sore throat': 'ಗಂಟಲು ನೋವು',
    'Fatigue': 'ಆಯಾಸ', 'Chest pain': 'ಎದೆ ನೋವು',
    'Difficulty breathing': 'ಉಸಿರಾಟ ತೊಂದರೆ',
  },
  'Bengali': {
    'Fever': 'জ্বর', 'Headache': 'মাথাব্যথা', 'Cough': 'কাশি',
    'Body pain': 'শরীর ব্যথা', 'Stomach pain': 'পেট ব্যথা',
    'Skin rash': 'ত্বকে ফুসকুড়ি', 'Vomiting': 'বমি',
    'Diarrhea': 'ডায়রিয়া', 'Sore throat': 'গলা ব্যথা',
    'Fatigue': 'ক্লান্তি', 'Chest pain': 'বুকে ব্যথা',
    'Difficulty breathing': 'শ্বাসকষ্ট',
  },
  'Marathi': {
    'Fever': 'ताप', 'Headache': 'डोकेदुखी', 'Cough': 'खोकला',
    'Body pain': 'अंगदुखी', 'Stomach pain': 'पोटदुखी',
    'Skin rash': 'त्वचेवर पुरळ', 'Vomiting': 'उलट्या',
    'Diarrhea': 'जुलाब', 'Sore throat': 'घसा दुखणे',
    'Fatigue': 'थकवा', 'Chest pain': 'छातीत दुखणे',
    'Difficulty breathing': 'श्वास घेण्यास त्रास',
  },
  'Urdu': {
    'Fever': 'بخار', 'Headache': 'سر درد', 'Cough': 'کھانسی',
    'Body pain': 'جسم میں درد', 'Stomach pain': 'پیٹ درد',
    'Skin rash': 'جلد پر دانے', 'Vomiting': 'الٹی',
    'Diarrhea': 'دست', 'Sore throat': 'گلے کی خراش',
    'Fatigue': 'تھکاوٹ', 'Chest pain': 'سینے میں درد',
    'Difficulty breathing': 'سانس لینے میں دشواری',
  },
};

/// Get the translated label for a symptom in the given language.
String _getSymptomLabel(String symptom, String language) {
  if (language == 'English') return symptom;
  return _symptomTranslations[language]?[symptom] ?? symptom;
}

/// AI Health Bot section for symptom analysis.
/// Supports text and voice input, shows structured health guidance
/// with risk level indicator, emergency hospital finder, and health history.
class HealthBotSection extends StatefulWidget {
  final String selectedLanguage;

  const HealthBotSection({super.key, required this.selectedLanguage});

  @override
  State<HealthBotSection> createState() => _HealthBotSectionState();
}

class _HealthBotSectionState extends State<HealthBotSection> {
  final TextEditingController _symptomController = TextEditingController();
  final SpeechService _speechService = SpeechService();
  final TtsService _ttsService = TtsService();
  final ScrollController _scrollController = ScrollController();

  bool _isAnalyzing = false;
  bool _isListening = false;
  String _analysisResult = '';
  String _riskLevel = 'LOW';
  final List<String> _selectedSymptoms = [];

  String _t(String key) => AppLocalizations.get(key);

  /// Add/remove a symptom chip.
  void _toggleSymptom(String symptom) {
    setState(() {
      if (_selectedSymptoms.contains(symptom)) {
        _selectedSymptoms.remove(symptom);
      } else {
        _selectedSymptoms.add(symptom);
      }
      _updateTextField();
    });
  }

  void _updateTextField() {
    final existing = _symptomController.text;
    final chipText = _selectedSymptoms.join(', ');
    final customParts = existing.split(',').map((s) => s.trim()).where(
        (s) => s.isNotEmpty && !_commonSymptoms.contains(s));
    final custom = customParts.join(', ');

    if (custom.isNotEmpty && chipText.isNotEmpty) {
      _symptomController.text = '$chipText, $custom';
    } else if (chipText.isNotEmpty) {
      _symptomController.text = chipText;
    }
    _symptomController.selection = TextSelection.fromPosition(
      TextPosition(offset: _symptomController.text.length),
    );
  }

  /// Voice input for symptoms — uses the selected language's locale.
  Future<void> _toggleVoiceInput() async {
    if (_isListening) {
      await _speechService.stopListening();
      setState(() => _isListening = false);
    } else {
      // Save text that existed before this listening session
      final textBefore = _symptomController.text.trim();

      // Look up the speech recognition locale for the selected language
      final localeId = widget.selectedLanguage == 'English'
          ? 'en_US'
          : TranslationService.speechLocaleCodes[widget.selectedLanguage] ?? 'en_US';

      await _speechService.startListening(
        localeId: localeId,
        onResult: (text, isFinal) {
          setState(() {
            // Replace (not append) — combine pre-existing text + current recognition
            if (textBefore.isNotEmpty) {
              _symptomController.text = '$textBefore, $text';
            } else {
              _symptomController.text = text;
            }
          });
          if (isFinal) {
            setState(() => _isListening = false);
          }
        },
      );
      setState(() => _isListening = true);
    }
  }

  /// Analyze symptoms via AI.
  Future<void> _analyzeSymptoms() async {
    final text = _symptomController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please describe your symptoms first'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isAnalyzing = true;
      _analysisResult = '';
      _riskLevel = 'LOW';
    });

    final result = await HealthBotService.analyzeSymptoms(text, language: widget.selectedLanguage);

    if (!mounted) return;

    final riskLevel = RiskLevelIndicator.parseFromAnalysis(result);

    setState(() {
      _analysisResult = result;
      _riskLevel = riskLevel;
      _isAnalyzing = false;
    });

    // Auto-save to health history (Feature 7)
    _saveToHistory(text, result, riskLevel);

    // Scroll to show results
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Save analysis result to health history.
  Future<void> _saveToHistory(String input, String result, String riskLevel) async {
    // Extract symptoms from input
    final symptoms = input.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

    // Create a short summary (first 100 chars of result)
    final summary = result.length > 100 ? '${result.substring(0, 100)}...' : result;

    await HealthHistoryService.saveEntry(HealthEntry(
      date: DateTime.now(),
      symptoms: symptoms,
      riskLevel: riskLevel,
      summary: summary,
      fullAnalysis: result,
    ));
  }

  void _copyResult() {
    if (_analysisResult.isEmpty) return;
    Clipboard.setData(ClipboardData(text: _analysisResult));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Health analysis copied!'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _speakResult() async {
    if (_analysisResult.isEmpty) return;
    await _ttsService.speak(_analysisResult, widget.selectedLanguage);
  }

  void _clearAll() {
    _symptomController.clear();
    setState(() {
      _analysisResult = '';
      _riskLevel = 'LOW';
      _selectedSymptoms.clear();
    });
  }

  @override
  void dispose() {
    _symptomController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEmergency = HospitalFinderService.isEmergencyResult(_analysisResult);

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      child: Column(
        children: [
          // Medical safety disclaimer banner (Feature 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.medical_information, color: Color(0xFFC62828), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _t('safetyBanner'),
                      style: const TextStyle(fontSize: 12, color: Color(0xFFB71C1C), height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Header card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              elevation: 0,
              color: const Color(0xFFE3F2FD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(Icons.health_and_safety, color: Color(0xFF1565C0), size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _t('aiHealthAssistant'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _t('regionAware'),
                            style: const TextStyle(fontSize: 14, color: Color(0xFF1565C0)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Symptom input card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _t('describeSymptoms'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _t('supportsLanguages'),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),

                    // Quick symptom chips
                    Text(
                      _t('tapSymptoms'),
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: _commonSymptoms.map((symptom) {
                        final isSelected = _selectedSymptoms.contains(symptom);
                        final isEmergencyChip = symptom == 'Chest pain' || symptom == 'Difficulty breathing';
                        return GestureDetector(
                          onTap: () => _toggleSymptom(symptom),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isEmergencyChip ? Colors.red.shade100 : const Color(0xFF4A90D9))
                                  : (isEmergencyChip ? Colors.red.shade50 : const Color(0xFFF5F5F5)),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? (isEmergencyChip ? Colors.red : const Color(0xFF4A90D9))
                                    : (isEmergencyChip ? Colors.red.shade200 : Colors.grey.shade400),
                              ),
                            ),
                            child: Text(
                              isSelected ? '✓ ${_getSymptomLabel(symptom, widget.selectedLanguage)}' : _getSymptomLabel(symptom, widget.selectedLanguage),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected
                                    ? (isEmergencyChip ? Colors.red.shade800 : Colors.white)
                                    : (isEmergencyChip ? Colors.red.shade700 : const Color(0xFF1A1A2E)),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),

                    // Text input with voice button
                    TextField(
                      controller: _symptomController,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: _t('symptomHint'),
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF4A90D9), width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(14),
                        suffixIcon: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                _isListening ? Icons.stop : Icons.mic,
                                color: _isListening ? Colors.red : const Color(0xFF4A90D9),
                              ),
                              onPressed: _toggleVoiceInput,
                              tooltip: _isListening ? _t('stop') : _t('speakSymptoms'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: _clearAll,
                              tooltip: _t('clear'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (_isListening)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.hearing, color: Colors.red, size: 18),
                            SizedBox(width: 6),
                            Text('Listening...', style: TextStyle(color: Colors.red, fontSize: 14)),
                          ],
                        ),
                      ),

                    const SizedBox(height: 14),

                    // Analyze button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton.icon(
                        onPressed: _isAnalyzing ? null : _analyzeSymptoms,
                        icon: Icon(
                          _isAnalyzing ? Icons.hourglass_top : Icons.search,
                          size: 26,
                        ),
                        label: Text(
                          _isAnalyzing ? _t('analyzing') : _t('analyzeSymptoms'),
                          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C5F8A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 14),
                      Text(
                        _t('analyzing'),
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFF2C5F8A)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _t('analyzingDesc'),
                        style: TextStyle(fontSize: 14, color: Color(0xFF5C6BC0)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Results
          if (_analysisResult.isNotEmpty && !_isAnalyzing)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  // === RISK LEVEL INDICATOR (Feature 4) ===
                  RiskLevelIndicator(riskLevel: _riskLevel),

                  // === FIND HOSPITAL BUTTON (Feature 1) ===
                  if (isEmergency)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () => EmergencyHospitalSheet.show(context, isEmergency: true),
                        icon: const Icon(Icons.local_hospital, size: 24),
                        label: Text(
                          _t('findHospital'),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  if (isEmergency) const SizedBox(height: 8),

                  // Analysis result card
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isEmergency ? Colors.red.shade300 : Colors.green.shade300,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Result header
                          Row(
                            children: [
                              Icon(
                                isEmergency ? Icons.warning_amber : Icons.check_circle_outline,
                                color: isEmergency ? Colors.red : Colors.green,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _t('healthAnalysis'),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A1A2E),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20),

                          // Result body
                          SelectableText(
                            _analysisResult,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Color(0xFF1A1A2E),
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Disclaimer
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, color: Color(0xFFE65100), size: 20),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _t('medicalDisclaimer'),
                                    style: TextStyle(fontSize: 13, color: Color(0xFFBF360C)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Action buttons
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 48,
                                  child: ElevatedButton.icon(
                                    onPressed: _speakResult,
                                    icon: const Icon(Icons.volume_up, size: 20),
                                    label: Text('${_t('readAloud')} (${widget.selectedLanguage})', style: const TextStyle(fontSize: 15)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2C5F8A),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 48,
                                child: OutlinedButton.icon(
                                  onPressed: _copyResult,
                                  icon: const Icon(Icons.copy, size: 18),
                                  label: Text(_t('copy'), style: const TextStyle(fontSize: 15)),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF2C5F8A),
                                    side: const BorderSide(color: Color(0xFF2C5F8A)),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // Non-emergency hospital button (always available)
                          if (!isEmergency)
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: OutlinedButton.icon(
                                onPressed: () => EmergencyHospitalSheet.show(context, isEmergency: false),
                                icon: const Icon(Icons.local_hospital, size: 18),
                                label: Text(_t('findHospitals')),
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
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
