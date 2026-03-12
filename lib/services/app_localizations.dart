/// Full app localization service.
/// Provides UI strings in English and Malayalam for all screens and widgets.
class AppLocalizations {
  static const Map<String, Map<String, String>> _strings = {
    'en': {
      // App
      'appName': 'MediBridge',
      'appSubtitle': 'Medical Language Assistant',

      // Tabs
      'tabEarlyWarning': 'Early Warning',
      'tabDoctor': 'Doctor',
      'tabPatient': 'Patient',
      'tabHealthBot': 'Health Bot',
      'tabOffline': 'Offline',

      // Language selector
      'selectLanguage': 'Select Patient Language',
      'patientLanguage': 'Patient Language:',

      // Doctor tab
      'doctorVoice': 'Doctor Voice',
      'typeMedicalInstruction': 'Type Medical Instruction',
      'quickPhrases': 'Quick Phrases — tap to use:',
      'translate': 'Translate',
      'translating': 'Translating...',
      'translatedOutput': 'Translated Output:',
      'playVoice': 'Play Voice',
      'copy': 'Copy',
      'clear': 'Clear',
      'explainPrescription': 'Explain Prescription',
      'generateExplanation': 'Generate Explanation',
      'generating': 'Generating...',
      'simpleExplanation': 'Simple Explanation:',
      'typeInstruction': 'Type medical instruction in English...',
      'pasteRx': 'Paste or type the prescription here...',

      // Patient tab
      'patientVoice': 'Patient Voice → English',
      'patientTapToSpeak': '🎤  Patient — Tap to Speak',
      'englishTranslation': 'English Translation (for Doctor):',
      'playEnglish': 'Play English',
      'patientInfo': 'This tab is for patients',
      'patientInfoDetail': 'Tap the microphone button above and speak in your language. '
          'Your words will be translated to English so the doctor can understand you.',

      // Health Bot
      'aiHealthAssistant': 'AI Health Assistant',
      'regionAware': 'Kerala / Kasaragod region-aware symptom analysis',
      'describeSymptoms': 'Describe Your Symptoms',
      'supportsLanguages': 'Supports English, Malayalam, or mixed (Manglish)',
      'tapSymptoms': 'Tap symptoms:',
      'analyzeSymptoms': '🔍  Analyze Symptoms',
      'analyzing': 'Analyzing...',
      'analyzingDesc': 'Considering Kerala / Kasaragod regional health patterns',
      'healthAnalysis': 'Health Analysis',
      'readAloud': 'Read Aloud',
      'medicalDisclaimer': '⚕️ This is NOT a medical diagnosis. Please consult a qualified doctor for proper treatment.',
      'safetyBanner': '⚕️ This tool provides GENERAL GUIDANCE only. It does NOT diagnose diseases or prescribe medicines. Always consult a qualified doctor.',
      'findHospital': '🚨  Find Nearest Hospital',
      'findHospitals': 'Find Hospitals Nearby',
      'symptomHint': 'e.g., Fever and body pain for 2 days...\nor: Enikku fever undu, body pain undu',
      'speakSymptoms': 'Speak symptoms',
      'stop': 'Stop',
      'riskLevel': 'RISK LEVEL',

      // Risk levels
      'riskEmergency': '🔴 EMERGENCY — Go to hospital immediately',
      'riskHigh': '🟠 HIGH RISK — Seek medical care today',
      'riskModerate': '🟡 MODERATE — Visit a clinic soon',
      'riskLow': '🟢 LOW RISK — Monitor symptoms at home',

      // Early Warning
      'earlyWarningTitle': 'Disease Early Warning Network',
      'earlyWarningSubtitle': 'AI-powered community health surveillance for Kerala',
      'reportSymptoms': 'Report Symptoms',
      'anonymous': 'Anonymous — No personal data collected',
      'yourArea': 'Your Area:',
      'selectSymptoms': 'Select Symptoms:',
      'submitReport': '📤  Submit Anonymous Report',
      'submitting': 'Submitting...',
      'outbreakDashboard': 'Outbreak Dashboard',
      'runAiAnalysis': '🔍 Run AI Analysis',
      'aiAnalyzing': 'AI analyzing patterns...',
      'doctorFeedback': 'Doctor Feedback',
      'doctorFeedbackSubtitle': 'Professional observations from local doctors',
      'simulationMode': '🎭 Simulation Mode — Demo for Judges',
      'hideSimulation': 'Hide Simulation',
      'outbreakSimulation': '🎭 Outbreak Simulation',
      'simulationDesc': 'Tap a scenario to inject realistic data into the dashboard:',
      'simulationDone': '✅ Simulation data injected! Dashboard updated.',
      'symptomTrends': 'Symptom Trends',
      'districtRiskMap': 'District Risk Heatmap',
      'districtRiskDesc': 'Kerala districts colored by report density',
      'healthAdvisories': 'Health Advisories',

      // District heatmap legend
      'low': 'Low',
      'medium': 'Medium',
      'high': 'High',
      'critical': 'Critical',

      // Outbreak dashboard
      'totalReports': 'Total Reports',
      'affectedAreas': 'Affected Areas',
      'topSymptoms': 'Top Symptoms',
      'reportedSymptoms': 'Reported symptoms',
      'noReports': 'No reports yet. Submit a symptom report above.',
      'riskAnalysis': 'Risk Analysis',

      // Report symptom widget
      'reportSymptomTitle': 'Report Community Symptoms',
      'reportSymptomDesc': 'Help detect outbreaks early by reporting symptoms in your area',
      'pleaseSelectArea': 'Please select your area',
      'pleaseSelectSymptom': 'Please select at least one symptom',
      'reportSubmitted': '✅ Report submitted! Thank you for helping protect your community.',

      // Hospital finder
      'emergencyDetected': '🚨 Emergency Detected',
      'findNearestHospital': 'Find nearest hospital or call ambulance',
      'nearbyHospitals': 'Nearby Hospitals',
      'callAmbulance': '📞  Call Ambulance — 108',
      'gettingLocation': 'Getting your location...',
      'locationError': 'Could not get your location. Showing all hospitals.',
      'hospitalsFound': 'hospitals found near you',
      'hospitalsInKerala': 'hospitals in Kerala',
      'navigate': 'Navigate',
      'call': 'Call',
      'kmAway': 'km away',
      'government': 'Govt',
      'private': 'Private',

      // Offline mode
      'offlineEmergencyMode': 'Offline Emergency Mode',
      'allOffline': 'All content works without internet',
      'emergencyNumbers': 'Emergency Numbers',
      'firstAidGuide': 'First Aid Guide',
      'firstAidSteps': 'First Aid Steps',

      // Health History
      'healthHistory': 'Health History',
      'noHistory': 'No health records yet',
      'noHistoryDesc': 'Your symptom analyses from the Health Bot will appear here.',
      'clearHistory': 'Clear',
      'clearHistoryTitle': 'Clear Health History?',
      'clearHistoryMsg': 'This will permanently delete all your health records.',
      'cancel': 'Cancel',
      'recurringSymptoms': 'Recurring Symptoms Detected',
      'recurringWarning': '⚠️ Please consult a doctor about these recurring symptoms.',
      'tapFullAnalysis': 'Tap to see full analysis →',
      'minAgo': 'min ago',
      'hAgo': 'h ago',
      'daysAgo': 'days ago',

      // Doctor Feedback
      'postedAgo': 'Posted',
      'verified': 'Verified',
      'privacyNote': 'General observations only — no patient data shared',

      // Common
      'tapToSpeak': '🎤  Tap to Speak',
      'stopRecording': 'Stop Recording',
      'listening': 'Listening...',
      'error': 'Error',
      'loading': 'Loading...',
      'copied': 'Copied!',
    },
    'ml': {
      // App
      'appName': 'മെഡിബ്രിഡ്ജ്',
      'appSubtitle': 'മെഡിക്കൽ ഭാഷാ സഹായി',

      // Tabs
      'tabEarlyWarning': 'മുന്നറിയിപ്പ്',
      'tabDoctor': 'ഡോക്ടർ',
      'tabPatient': 'രോഗി',
      'tabHealthBot': 'ഹെൽത്ത് ബോട്ട്',
      'tabOffline': 'ഓഫ്‌ലൈൻ',

      // Language selector
      'selectLanguage': 'രോഗിയുടെ ഭാഷ തിരഞ്ഞെടുക്കുക',
      'patientLanguage': 'രോഗിയുടെ ഭാഷ:',

      // Doctor tab
      'doctorVoice': 'ഡോക്ടറുടെ ശബ്ദം',
      'typeMedicalInstruction': 'മെഡിക്കൽ നിർദ്ദേശം ടൈപ്പ് ചെയ്യുക',
      'quickPhrases': 'ദ്രുത വാക്യങ്ങൾ — ടാപ്പ് ചെയ്യുക:',
      'translate': 'വിവര്‍ത്തനം ചെയ്യുക',
      'translating': 'വിവര്‍ത്തനം ചെയ്യുന്നു...',
      'translatedOutput': 'വിവര്‍ത്തനം:',
      'playVoice': 'ശബ്ദം കേൾക്കുക',
      'copy': 'പകർത്തുക',
      'clear': 'മായ്ക്കുക',
      'explainPrescription': 'കുറിപ്പടി വിശദീകരിക്കുക',
      'generateExplanation': 'വിശദീകരണം ഉണ്ടാക്കുക',
      'generating': 'ഉണ്ടാക്കുന്നു...',
      'simpleExplanation': 'ലളിത വിശദീകരണം:',
      'typeInstruction': 'ഇംഗ്ലീഷിൽ മെഡിക്കൽ നിർദ്ദേശം ടൈപ്പ് ചെയ്യുക...',
      'pasteRx': 'കുറിപ്പടി ഇവിടെ ടൈപ്പ് ചെയ്യുക...',

      // Patient tab
      'patientVoice': 'രോഗിയുടെ ശബ്ദം → ഇംഗ്ലീഷ്',
      'patientTapToSpeak': '🎤  രോഗി — സംസാരിക്കാൻ ടാപ്പ് ചെയ്യുക',
      'englishTranslation': 'ഇംഗ്ലീഷ് വിവര്‍ത്തനം (ഡോക്ടർക്ക്):',
      'playEnglish': 'ഇംഗ്ലീഷ് കേൾക്കുക',
      'patientInfo': 'ഈ ടാബ് രോഗികൾക്കുള്ളതാണ്',
      'patientInfoDetail': 'മുകളിലെ മൈക്രോഫോൺ ബട്ടൺ ടാപ്പ് ചെയ്ത് നിങ്ങളുടെ ഭാഷയിൽ സംസാരിക്കുക.',

      // Health Bot
      'aiHealthAssistant': 'AI ആരോഗ്യ സഹായി',
      'regionAware': 'കേരള / കാസർഗോഡ് പ്രദേശ അധിഷ്ഠിത ലക്ഷണ വിശകലനം',
      'describeSymptoms': 'നിങ്ങളുടെ ലക്ഷണങ്ങൾ വിവരിക്കുക',
      'supportsLanguages': 'ഇംഗ്ലീഷ്, മലയാളം, അല്ലെങ്കിൽ മിശ്രിതം',
      'tapSymptoms': 'ലക്ഷണങ്ങൾ ടാപ്പ് ചെയ്യുക:',
      'analyzeSymptoms': '🔍  ലക്ഷണങ്ങൾ വിശകലനം ചെയ്യുക',
      'analyzing': 'വിശകലനം ചെയ്യുന്നു...',
      'analyzingDesc': 'കേരള / കാസർഗോഡ് ആരോഗ്യ രീതികൾ പരിഗണിക്കുന്നു',
      'healthAnalysis': 'ആരോഗ്യ വിശകലനം',
      'readAloud': 'ഉറക്കെ വായിക്കുക',
      'medicalDisclaimer': '⚕️ ഇത് മെഡിക്കൽ രോഗനിർണ്ണയമല്ല. ശരിയായ ചികിത്സയ്ക്ക് ഡോക്ടറെ സമീപിക്കുക.',
      'safetyBanner': '⚕️ ഈ ഉപകരണം പൊതു മാർഗ്ഗനിർദ്ദേശം മാത്രം. രോഗനിർണ്ണയം നടത്തുന്നില്ല. എല്ലായ്പ്പോഴും ഡോക്ടറെ സമീപിക്കുക.',
      'findHospital': '🚨  അടുത്തുള്ള ആശുപത്രി കണ്ടെത്തുക',
      'findHospitals': 'ആശുപത്രികൾ കണ്ടെത്തുക',
      'symptomHint': 'ഉദാ: പനിയും ശരീരവേദനയും 2 ദിവസമായി...',
      'speakSymptoms': 'ലക്ഷണങ്ങൾ പറയുക',
      'stop': 'നിർത്തുക',
      'riskLevel': 'അപകട നില',

      // Risk levels
      'riskEmergency': '🔴 അടിയന്തരം — ഉടൻ ആശുപത്രിയിൽ പോകുക',
      'riskHigh': '🟠 ഉയർന്ന അപകടം — ഇന്ന് വൈദ്യസഹായം തേടുക',
      'riskModerate': '🟡 മിതമായ — ഉടൻ ക്ലിനിക് സന്ദർശിക്കുക',
      'riskLow': '🟢 കുറഞ്ഞ അപകടം — വീട്ടിൽ നിരീക്ഷിക്കുക',

      // Early Warning
      'earlyWarningTitle': 'രോഗ മുന്നറിയിപ്പ് ശൃംഖല',
      'earlyWarningSubtitle': 'കേരളത്തിനായുള്ള AI അധിഷ്ഠിത ആരോഗ്യ നിരീക്ഷണം',
      'reportSymptoms': 'ലക്ഷണങ്ങൾ റിപ്പോർട്ട് ചെയ്യുക',
      'anonymous': 'അജ്ഞാതം — വ്യക്തിഗത ഡാറ്റ ശേഖരിക്കില്ല',
      'yourArea': 'നിങ്ങളുടെ പ്രദേശം:',
      'selectSymptoms': 'ലക്ഷണങ്ങൾ തിരഞ്ഞെടുക്കുക:',
      'submitReport': '📤  അജ്ഞാത റിപ്പോർട്ട് സമർപ്പിക്കുക',
      'submitting': 'സമർപ്പിക്കുന്നു...',
      'outbreakDashboard': 'പകർച്ചവ്യാധി ഡാഷ്ബോർഡ്',
      'runAiAnalysis': '🔍 AI വിശകലനം നടത്തുക',
      'aiAnalyzing': 'AI ക്രമങ്ങൾ വിശകലനം ചെയ്യുന്നു...',
      'doctorFeedback': 'ഡോക്ടർ ഫീഡ്ബാക്ക്',
      'doctorFeedbackSubtitle': 'പ്രാദേശിക ഡോക്ടർമാരുടെ പ്രൊഫഷണൽ നിരീക്ഷണങ്ങൾ',
      'simulationMode': '🎭 സിമുലേഷൻ — ജഡ്ജസിനുള്ള ഡെമോ',
      'hideSimulation': 'സിമുലേഷൻ മറയ്ക്കുക',
      'outbreakSimulation': '🎭 പകർച്ചവ്യാധി സിമുലേഷൻ',
      'simulationDesc': 'ഡാഷ്ബോർഡിലേക്ക് യഥാർത്ഥ ഡാറ്റ ചേർക്കാൻ ടാപ്പ് ചെയ്യുക:',
      'simulationDone': '✅ സിമുലേഷൻ ഡാറ്റ ചേർത്തു! ഡാഷ്ബോർഡ് അപ്ഡേറ്റ് ചെയ്തു.',
      'symptomTrends': 'ലക്ഷണ പ്രവണതകൾ',
      'districtRiskMap': 'ജില്ലാ റിസ്ക് ഹീറ്റ്മാപ്പ്',
      'districtRiskDesc': 'റിപ്പോർട്ട് സാന്ദ്രത അനുസരിച്ച് നിറം',
      'healthAdvisories': 'ആരോഗ്യ ഉപദേശങ്ങൾ',

      // District heatmap legend
      'low': 'കുറവ്',
      'medium': 'മിതം',
      'high': 'ഉയർന്നത്',
      'critical': 'ഗുരുതരം',

      // Outbreak dashboard
      'totalReports': 'ആകെ റിപ്പോർട്ടുകൾ',
      'affectedAreas': 'ബാധിത പ്രദേശങ്ങൾ',
      'topSymptoms': 'പ്രധാന ലക്ഷണങ്ങൾ',
      'reportedSymptoms': 'റിപ്പോർട്ട് ചെയ്ത ലക്ഷണങ്ങൾ',
      'noReports': 'ഇതുവരെ റിപ്പോർട്ടുകൾ ഇല്ല. ലക്ഷണം റിപ്പോർട്ട് ചെയ്യുക.',
      'riskAnalysis': 'റിസ്ക് വിശകലനം',

      // Report symptom widget
      'reportSymptomTitle': 'കമ്മ്യൂണിറ്റി ലക്ഷണങ്ങൾ റിപ്പോർട്ട് ചെയ്യുക',
      'reportSymptomDesc': 'ലക്ഷണങ്ങൾ റിപ്പോർട്ട് ചെയ്ത് പകർച്ചവ്യാധികൾ നേരത്തെ കണ്ടെത്താൻ സഹായിക്കുക',
      'pleaseSelectArea': 'നിങ്ങളുടെ പ്രദേശം തിരഞ്ഞെടുക്കുക',
      'pleaseSelectSymptom': 'ഒരു ലക്ഷണമെങ്കിലും തിരഞ്ഞെടുക്കുക',
      'reportSubmitted': '✅ റിപ്പോർട്ട് സമർപ്പിച്ചു! സമൂഹത്തെ സംരക്ഷിക്കാൻ സഹായിച്ചതിന് നന്ദി.',

      // Hospital finder
      'emergencyDetected': '🚨 അടിയന്തരം കണ്ടെത്തി',
      'findNearestHospital': 'അടുത്തുള്ള ആശുപത്രി കണ്ടെത്തുക അല്ലെങ്കിൽ ആംബുലൻസ് വിളിക്കുക',
      'nearbyHospitals': 'അടുത്തുള്ള ആശുപത്രികൾ',
      'callAmbulance': '📞  ആംബുലൻസ് വിളിക്കുക — 108',
      'gettingLocation': 'നിങ്ങളുടെ ലൊക്കേഷൻ കണ്ടെത്തുന്നു...',
      'locationError': 'ലൊക്കേഷൻ കണ്ടെത്താനായില്ല. എല്ലാ ആശുപത്രികളും കാണിക്കുന്നു.',
      'hospitalsFound': 'ആശുപത്രികൾ കണ്ടെത്തി',
      'hospitalsInKerala': 'കേരളത്തിലെ ആശുപത്രികൾ',
      'navigate': 'വഴി കാണിക്കുക',
      'call': 'വിളിക്കുക',
      'kmAway': 'കി.മി.',
      'government': 'സർക്കാർ',
      'private': 'സ്വകാര്യം',

      // Offline mode
      'offlineEmergencyMode': 'ഓഫ്‌ലൈൻ അടിയന്തര മോഡ്',
      'allOffline': 'ഇന്റർനെറ്റ് ഇല്ലാതെ പ്രവർത്തിക്കുന്നു',
      'emergencyNumbers': 'അടിയന്തര നമ്പറുകൾ',
      'firstAidGuide': 'പ്രഥമ ശുശ്രൂഷ ഗൈഡ്',
      'firstAidSteps': 'പ്രഥമ ശുശ്രൂഷ',

      // Health History
      'healthHistory': 'ആരോഗ്യ ചരിത്രം',
      'noHistory': 'ആരോഗ്യ രേഖകൾ ഇല്ല',
      'noHistoryDesc': 'ഹെൽത്ത് ബോട്ടിൽ നിന്ന് വിശകലനങ്ങൾ ഇവിടെ ദൃശ്യമാകും.',
      'clearHistory': 'മായ്ക്കുക',
      'clearHistoryTitle': 'ആരോഗ്യ ചരിത്രം മായ്ക്കണോ?',
      'clearHistoryMsg': 'ഇത് എല്ലാ ആരോഗ്യ രേഖകളും ശാശ്വതമായി ഇല്ലാതാക്കും.',
      'cancel': 'റദ്ദാക്കുക',
      'recurringSymptoms': 'ആവർത്തിക്കുന്ന ലക്ഷണങ്ങൾ',
      'recurringWarning': '⚠️ ഈ ആവർത്തിക്കുന്ന ലക്ഷണങ്ങളെക്കുറിച്ച് ഡോക്ടറെ സമീപിക്കുക.',
      'tapFullAnalysis': 'മുഴുവൻ വിശകലനം കാണാൻ ടാപ്പ് ചെയ്യുക →',
      'minAgo': 'മിനിറ്റ് മുമ്പ്',
      'hAgo': 'മണിക്കൂർ മുമ്പ്',
      'daysAgo': 'ദിവസം മുമ്പ്',

      // Doctor Feedback
      'postedAgo': 'പോസ്റ്റ് ചെയ്തു',
      'verified': 'സ്ഥിരീകരിച്ചു',
      'privacyNote': 'പൊതു നിരീക്ഷണങ്ങൾ മാത്രം — രോഗി ഡാറ്റ പങ്കിടില്ല',

      // Common
      'tapToSpeak': '🎤  സംസാരിക്കാൻ ടാപ്പ് ചെയ്യുക',
      'stopRecording': 'റെക്കോർഡിംഗ് നിർത്തുക',
      'listening': 'കേൾക്കുന്നു...',
      'error': 'പിശക്',
      'loading': 'ലോഡിംഗ്...',
      'copied': 'പകർത്തി!',
    },
  };

  /// Current app locale (mutable for global access).
  static String currentLocale = 'en';

  /// Get a localized string.
  static String get(String key, {String? locale}) {
    final l = locale ?? currentLocale;
    return _strings[l]?[key] ?? _strings['en']?[key] ?? key;
  }

  /// Get all strings for a locale.
  static Map<String, String> allStrings({String? locale}) {
    final l = locale ?? currentLocale;
    return _strings[l] ?? _strings['en']!;
  }

  /// Available UI languages.
  static const List<String> availableLocales = ['en', 'ml'];

  /// UI language display names.
  static const Map<String, String> localeNames = {
    'en': 'English',
    'ml': 'മലയാളം',
  };
}
