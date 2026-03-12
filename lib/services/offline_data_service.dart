/// Offline emergency data service.
/// Provides pre-translated medical phrases, first aid steps,
/// and emergency contacts — all hardcoded for offline use.
class OfflineDataService {
  /// Emergency contact numbers for Kerala with multi-language labels.
  static const List<EmergencyContact> emergencyContacts = [
    EmergencyContact(
      number: '108',
      english: 'Kerala Ambulance',
      malayalam: 'കേരള ആംബുലൻസ്',
      hindi: 'केरल एम्बुलेंस',
      tamil: 'கேரள ஆம்புலன்ஸ்',
      kannada: 'ಕೇರಳ ಆಂಬ್ಯುಲೆನ್ಸ್',
    ),
    EmergencyContact(
      number: '100',
      english: 'Police',
      malayalam: 'പോലീസ്',
      hindi: 'पुलिस',
      tamil: 'காவல்துறை',
      kannada: 'ಪೊಲೀಸ್',
    ),
    EmergencyContact(
      number: '101',
      english: 'Fire',
      malayalam: 'അഗ്നിശമന സേന',
      hindi: 'दमकल',
      tamil: 'தீயணைப்பு',
      kannada: 'ಅಗ್ನಿಶಾಮಕ',
    ),
    EmergencyContact(
      number: '181',
      english: 'Women Helpline',
      malayalam: 'വനിതാ ഹെൽപ്‌ലൈൻ',
      hindi: 'महिला हेल्पलाइन',
      tamil: 'பெண்கள் உதவி எண்',
      kannada: 'ಮಹಿಳಾ ಸಹಾಯವಾಣಿ',
    ),
    EmergencyContact(
      number: '1077',
      english: 'Disaster Management',
      malayalam: 'ദുരന്ത നിവാരണം',
      hindi: 'आपदा प्रबंधन',
      tamil: 'பேரிடர் மேலாண்மை',
      kannada: 'ವಿಪತ್ತು ನಿರ್ವಹಣೆ',
    ),
    EmergencyContact(
      number: '1056',
      english: 'Health Helpline (Disha)',
      malayalam: 'ആരോഗ്യ ഹെൽപ്‌ലൈൻ (ദിശ)',
      hindi: 'स्वास्थ्य हेल्पलाइन (दिशा)',
      tamil: 'சுகாதார உதவி எண் (திசா)',
      kannada: 'ಆರೋಗ್ಯ ಸಹಾಯವಾಣಿ (ದಿಶಾ)',
    ),
    EmergencyContact(
      number: '1098',
      english: 'Child Helpline',
      malayalam: 'ശിശു ഹെൽപ്‌ലൈൻ',
      hindi: 'चाइल्ड हेल्पलाइन',
      tamil: 'குழந்தை உதவி எண்',
      kannada: 'ಮಕ್ಕಳ ಸಹಾಯವಾಣಿ',
    ),
    EmergencyContact(
      number: '1066',
      english: 'Poison Control',
      malayalam: 'വിഷ നിയന്ത്രണം',
      hindi: 'विष नियंत्रण',
      tamil: 'நச்சுக் கட்டுப்பாடு',
      kannada: 'ವಿಷ ನಿಯಂತ್ರಣ',
    ),
  ];

  /// Pre-translated medical phrases organized by category.
  /// Each phrase has translations in Malayalam, Hindi, Tamil, and Kannada.
  static const List<OfflinePhrase> emergencyPhrases = [
    // === EMERGENCY PHRASES ===
    OfflinePhrase(
      category: 'Emergency',
      english: 'Go to the nearest hospital immediately.',
      malayalam: 'ഉടൻ തന്നെ ഏറ്റവും അടുത്തുള്ള ആശുപത്രിയിൽ പോകുക.',
      hindi: 'तुरंत नजदीकी अस्पताल जाएं।',
      tamil: 'உடனடியாக அருகிலுள்ள மருத்துவமனைக்குச் செல்லுங்கள்.',
      kannada: 'ತಕ್ಷಣ ಹತ್ತಿರದ ಆಸ್ಪತ್ರೆಗೆ ಹೋಗಿ.',
    ),
    OfflinePhrase(
      category: 'Emergency',
      english: 'Call an ambulance. Dial 108.',
      malayalam: 'ആംബുലൻസ് വിളിക്കുക. 108 ഡയൽ ചെയ്യുക.',
      hindi: 'एम्बुलेंस बुलाएं। 108 डायल करें।',
      tamil: 'ஆம்புலன்ஸ் அழைக்கவும். 108 டயல் செய்யவும்.',
      kannada: 'ಆಂಬ್ಯುಲೆನ್ಸ್ ಕರೆಯಿರಿ. 108 ಡಯಲ್ ಮಾಡಿ.',
    ),
    OfflinePhrase(
      category: 'Emergency',
      english: 'Can you breathe?',
      malayalam: 'നിങ്ങൾക്ക് ശ്വസിക്കാൻ കഴിയുമോ?',
      hindi: 'क्या आप सांस ले पा रहे हैं?',
      tamil: 'உங்களால் மூச்சு விட முடிகிறதா?',
      kannada: 'ನೀವು ಉಸಿರಾಡಬಹುದೇ?',
    ),
    OfflinePhrase(
      category: 'Emergency',
      english: 'Do not move the patient.',
      malayalam: 'രോഗിയെ നീക്കരുത്.',
      hindi: 'मरीज को हिलाएं नहीं।',
      tamil: 'நோயாளியை நகர்த்தாதீர்கள்.',
      kannada: 'ರೋಗಿಯನ್ನು ಸ್ಥಳಾಂತರಿಸಬೇಡಿ.',
    ),
    // === DOCTOR QUESTIONS ===
    OfflinePhrase(
      category: 'Doctor Questions',
      english: 'Where is the pain?',
      malayalam: 'വേദന എവിടെയാണ്?',
      hindi: 'दर्द कहां है?',
      tamil: 'வலி எங்கே உள்ளது?',
      kannada: 'ನೋವು ಎಲ್ಲಿದೆ?',
    ),
    OfflinePhrase(
      category: 'Doctor Questions',
      english: 'How long have you had these symptoms?',
      malayalam: 'ഈ ലക്ഷണങ്ങൾ എത്ര നാളായി?',
      hindi: 'ये लक्षण कब से हैं?',
      tamil: 'இந்த அறிகுறிகள் எவ்வளவு நாட்களாக உள்ளன?',
      kannada: 'ಈ ಲಕ್ಷಣಗಳು ಎಷ್ಟು ಸಮಯದಿಂದ ಇವೆ?',
    ),
    OfflinePhrase(
      category: 'Doctor Questions',
      english: 'Do you have any allergies?',
      malayalam: 'നിങ്ങൾക്ക് എന്തെങ്കിലും അലർജിയുണ്ടോ?',
      hindi: 'क्या आपको कोई एलर्जी है?',
      tamil: 'உங்களுக்கு ஏதாவது ஒவ்வாமை உள்ளதா?',
      kannada: 'ನಿಮಗೆ ಯಾವುದೇ ಅಲರ್ಜಿ ಇದೆಯೇ?',
    ),
    OfflinePhrase(
      category: 'Doctor Questions',
      english: 'Are you taking any medicines?',
      malayalam: 'നിങ്ങൾ എന്തെങ്കിലും മരുന്ന് കഴിക്കുന്നുണ്ടോ?',
      hindi: 'क्या आप कोई दवाई ले रहे हैं?',
      tamil: 'நீங்கள் ஏதாவது மருந்து எடுத்துக் கொள்கிறீர்களா?',
      kannada: 'ನೀವು ಯಾವುದೇ ಔಷಧಿ ತೆಗೆದುಕೊಳ್ಳುತ್ತಿದ್ದೀರಾ?',
    ),
    OfflinePhrase(
      category: 'Doctor Questions',
      english: 'When did the fever start?',
      malayalam: 'പനി എപ്പോഴാണ് തുടങ്ങിയത്?',
      hindi: 'बुखार कब शुरू हुआ?',
      tamil: 'காய்ச்சல் எப்போது தொடங்கியது?',
      kannada: 'ಜ್ವರ ಯಾವಾಗ ಪ್ರಾರಂಭವಾಯಿತು?',
    ),
    OfflinePhrase(
      category: 'Doctor Questions',
      english: 'Show me where it hurts.',
      malayalam: 'എവിടെയാണ് വേദനിക്കുന്നതെന്ന് കാണിക്കൂ.',
      hindi: 'दिखाओ कहां दर्द हो रहा है।',
      tamil: 'எங்கு வலிக்கிறது என்று காட்டுங்கள்.',
      kannada: 'ಎಲ್ಲಿ ನೋವು ಇದೆ ಎಂದು ತೋರಿಸಿ.',
    ),
    // === MEDICAL INSTRUCTIONS ===
    OfflinePhrase(
      category: 'Medical Instructions',
      english: 'Take this medicine after food.',
      malayalam: 'ഈ മരുന്ന് ഭക്ഷണത്തിന് ശേഷം കഴിക്കുക.',
      hindi: 'यह दवाई खाने के बाद लें।',
      tamil: 'இந்த மருந்தை உணவுக்குப் பிறகு எடுத்துக்கொள்ளுங்கள்.',
      kannada: 'ಈ ಔಷಧಿಯನ್ನು ಊಟದ ನಂತರ ತೆಗೆದುಕೊಳ್ಳಿ.',
    ),
    OfflinePhrase(
      category: 'Medical Instructions',
      english: 'Drink plenty of water.',
      malayalam: 'ധാരാളം വെള്ളം കുടിക്കുക.',
      hindi: 'खूब पानी पीजिए।',
      tamil: 'நிறைய தண்ணீர் குடியுங்கள்.',
      kannada: 'ಸಾಕಷ್ಟು ನೀರು ಕುಡಿಯಿರಿ.',
    ),
    OfflinePhrase(
      category: 'Medical Instructions',
      english: 'You need complete rest for 3 days.',
      malayalam: '3 ദിവസം പൂർണ്ണ വിശ്രമം ആവശ്യമാണ്.',
      hindi: '3 दिन पूरा आराम करना जरूरी है।',
      tamil: '3 நாட்கள் முழு ஓய்வு தேவை.',
      kannada: '3 ದಿನಗಳ ಕಾಲ ಸಂಪೂರ್ಣ ವಿಶ್ರಾಂತಿ ಬೇಕು.',
    ),
    OfflinePhrase(
      category: 'Medical Instructions',
      english: 'Come back for a check-up after 5 days.',
      malayalam: '5 ദിവസത്തിന് ശേഷം പരിശോധനയ്ക്ക് വരൂ.',
      hindi: '5 दिन बाद जांच के लिए आएं।',
      tamil: '5 நாட்களுக்குப் பிறகு பரிசோதனைக்கு வாருங்கள்.',
      kannada: '5 ದಿನಗಳ ನಂತರ ತಪಾಸಣೆಗೆ ಬನ್ನಿ.',
    ),
    OfflinePhrase(
      category: 'Medical Instructions',
      english: 'Do not eat spicy or oily food.',
      malayalam: 'എരിവുള്ളതോ എണ്ണയിൽ വറുത്തതോ ആയ ഭക്ഷണം കഴിക്കരുത്.',
      hindi: 'तीखा या तला हुआ खाना मत खाइए।',
      tamil: 'காரமான அல்லது எண்ணெயில் பொரித்த உணவு சாப்பிடாதீர்கள்.',
      kannada: 'ಖಾರ ಅಥಹ ಎಣ್ಣೆಯಲ್ಲಿ ಕರಿದ ಆಹಾರ ತಿನ್ನಬೇಡಿ.',
    ),
    OfflinePhrase(
      category: 'Medical Instructions',
      english: 'Apply this ointment on the affected area.',
      malayalam: 'ബാധിച്ച ഭാഗത്ത് ഈ ലേപനം പുരട്ടുക.',
      hindi: 'प्रभावित जगह पर यह मलहम लगाएं।',
      tamil: 'பாதிக்கப்பட்ட பகுதியில் இந்த மருந்தை தடவுங்கள்.',
      kannada: 'ಬಾಧಿತ ಪ್ರದೇಶದ ಮೇಲೆ ಈ ಮುಲಾಮು ಹಚ್ಚಿ.',
    ),
    // === FIRST AID ===
    OfflinePhrase(
      category: 'First Aid',
      english: 'Apply ice to reduce swelling.',
      malayalam: 'വീക്കം കുറയ്ക്കാൻ ഐസ് വയ്ക്കുക.',
      hindi: 'सूजन कम करने के लिए बर्फ लगाएं।',
      tamil: 'வீக்கத்தைக் குறைக்க ஐஸ் வையுங்கள்.',
      kannada: 'ಊತ ಕಡಿಮೆ ಮಾಡಲು ಐಸ್ ಹಾಕಿ.',
    ),
    OfflinePhrase(
      category: 'First Aid',
      english: 'Clean the wound with clean water.',
      malayalam: 'ശുദ്ധമായ വെള്ളം ഉപയോഗിച്ച് മുറിവ് വൃത്തിയാക്കുക.',
      hindi: 'साफ पानी से घाव को धोएं।',
      tamil: 'சுத்தமான தண்ணீரால் காயத்தை சுத்தம் செய்யுங்கள்.',
      kannada: 'ಶುದ್ಧ ನೀರಿನಿಂದ ಗಾಯವನ್ನು ಸ್ವಚ್ಛಗೊಳಿಸಿ.',
    ),
    OfflinePhrase(
      category: 'First Aid',
      english: 'Keep the person lying down. Do not let them walk.',
      malayalam: 'രോഗിയെ കിടത്തുക. നടക്കാൻ അനുവദിക്കരുത്.',
      hindi: 'व्यक्ति को लेटा कर रखें। चलने मत दें।',
      tamil: 'நோயாளியை படுக்க வையுங்கள். நடக்க விடாதீர்கள்.',
      kannada: 'ವ್ಯಕ್ತಿಯನ್ನು ಮಲಗಿಸಿ. ನಡೆಯಲು ಬಿಡಬೇಡಿ.',
    ),
    OfflinePhrase(
      category: 'First Aid',
      english: 'For snake bite: keep still, do not cut or suck the wound.',
      malayalam: 'പാമ്പ് കടിച്ചാൽ: അനങ്ങാതിരിക്കുക, മുറിവ് മുറിക്കുകയോ ഊറ്റുകയോ ചെയ്യരുത്.',
      hindi: 'सांप के काटने पर: हिलें नहीं, घाव को काटें या चूसें नहीं।',
      tamil: 'பாம்பு கடித்தால்: அசையாதீர்கள், காயத்தை வெட்ட அல்லது உறிஞ்ச வேண்டாம்.',
      kannada: 'ಹಾವು ಕಡಿದರೆ: ಅಲ್ಲಾಡಬೇಡಿ, ಗಾಯವನ್ನು ಕತ್ತರಿಸಬೇಡಿ ಅಥವಹ ಹೀರಬೇಡಿ.',
    ),
    OfflinePhrase(
      category: 'First Aid',
      english: 'For burns: run cool water for 10 minutes. Do not apply ice.',
      malayalam: 'പൊള്ളലിന്: 10 മിനിറ്റ് തണുത്ത വെള്ളം ഒഴിക്കുക. ഐസ് ഉപയോഗിക്കരുത്.',
      hindi: 'जलने पर: 10 मिनट ठंडा पानी डालें। बर्फ न लगाएं।',
      tamil: 'தீக்காயத்திற்கு: 10 நிமிடம் குளிர்ந்த நீர் ஊற்றுங்கள். ஐஸ் வைக்காதீர்கள்.',
      kannada: 'ಸುಟ್ಟಗಾಯಕ್ಕೆ: 10 ನಿಮಿಷ ತಣ್ಣೀರು ಹಾಕಿ. ಐಸ್ ಹಾಕಬೇಡಿ.',
    ),
    // === PATIENT COMFORT ===
    OfflinePhrase(
      category: 'Patient Comfort',
      english: 'Don\'t worry, you will be fine.',
      malayalam: 'വിഷಮിക്കേണ്ട, നിങ്ങൾ സുഖമാകും.',
      hindi: 'चिंता मत करो, आप ठीक हो जाएंगे।',
      tamil: 'கவலைப்படாதீர்கள், நீங்கள் குணமாவீர்கள்.',
      kannada: 'ಚಿಂತಿಸಬೇಡಿ, ನೀವು ಗುಣಮುಖರಾಗುತ್ತೀರಿ.',
    ),
    OfflinePhrase(
      category: 'Patient Comfort',
      english: 'The doctor will see you soon.',
      malayalam: 'ഡോക്ടർ ഉടൻ നിങ്ങളെ പരിശോധിക്കും.',
      hindi: 'डॉक्टर जल्दी आपको देखेंगे।',
      tamil: 'டாக்டர் விரைவில் உங்களைப் பார்ப்பார்.',
      kannada: 'ವೈದ್ಯರು ಶೀಘ್ರದಲ್ಲಿ ನಿಮ್ಮನ್ನು ನೋಡುತ್ತಾರೆ.',
    ),
    OfflinePhrase(
      category: 'Patient Comfort',
      english: 'Take deep breaths slowly.',
      malayalam: 'പതുക്കെ ആഴത്തിൽ ശ്വസിക്കുക.',
      hindi: 'धीरे-धीरे गहरी सांस लें।',
      tamil: 'மெதுவாக ஆழமாக மூச்சு விடுங்கள்.',
      kannada: 'ನಿಧಾನವಾಗಿ ಆಳವಾಗಿ ಉಸಿರಾಡಿ.',
    ),
  ];

  /// Get phrases filtered by category.
  static List<OfflinePhrase> getPhrasesByCategory(String category) {
    return emergencyPhrases.where((p) => p.category == category).toList();
  }

  /// Get all unique categories.
  static List<String> get categories {
    return emergencyPhrases.map((p) => p.category).toSet().toList();
  }

  /// First aid steps for common emergencies with multi-language support.
  static const List<FirstAidStep> firstAidSteps = [
    FirstAidStep(
      title: 'Heart Attack',
      titleMl: 'ഹൃദയാഘാതം',
      titleHi: 'दिल का दौरा',
      titleTa: 'மாரடைப்பு',
      titleKn: 'ಹೃದಯಾಘಾತ',
      steps: [
        'Call 108 immediately',
        'Have the person sit down and rest',
        'Loosen any tight clothing',
        'If they take heart medication, help them take it',
        'If unconscious, begin CPR',
      ],
      stepsMl: [
        'ഉടൻ 108 വിളിക്കുക',
        'രോഗിയെ ഇരുത്തി വിശ്രമിക്കാൻ സഹായിക്കുക',
        'ഇറുകിയ വസ്ത്രങ്ങൾ അയയ്ക്കുക',
        'ഹൃദ്രോഗ മരുന്ന് കഴിക്കുന്നുണ്ടെങ്കിൽ അത് കഴിക്കാൻ സഹായിക്കുക',
        'ബോധമില്ലെങ്കിൽ CPR ആരംഭിക്കുക',
      ],
      stepsHi: [
        'तुरंत 108 पर कॉल करें',
        'व्यक्ति को बैठाकर आराम करने दें',
        'तंग कपड़े ढीले करें',
        'अगर वे दिल की दवाई लेते हैं तो उन्हें लेने में मदद करें',
        'अगर बेहोश हो तो CPR शुरू करें',
      ],
      stepsTa: [
        'உடனடியாக 108 அழைக்கவும்',
        'நபரை உட்காரவைத்து ஓய்வெடுக்கச் செய்யுங்கள்',
        'இறுக்கமான ஆடைகளை தளர்த்துங்கள்',
        'இதய மருந்து எடுப்பவர் என்றால் எடுக்க உதவுங்கள்',
        'நினைவிழந்தால் CPR தொடங்குங்கள்',
      ],
      stepsKn: [
        'ತಕ್ಷಣ 108 ಗೆ ಕರೆ ಮಾಡಿ',
        'ವ್ಯಕ್ತಿಯನ್ನು ಕುಳಿತುಕೊಳ್ಳಿಸಿ ವಿಶ್ರಾಂತಿ ನೀಡಿ',
        'ಬಿಗಿಯಾದ ಬಟ್ಟೆಗಳನ್ನು ಸಡಿಲಗೊಳಿಸಿ',
        'ಹೃದಯ ಔಷಧಿ ತೆಗೆಸುಕೊಳ್ಳುತ್ತಿದ್ದರೆ ಸಹಾಯ ಮಾಡಿ',
        'ಪ್ರಜ್ಞೆ ಇಲ್ಲದಿದ್ದರೆ CPR ಪ್ರಾರಂಭಿಸಿ',
      ],
    ),
    FirstAidStep(
      title: 'Drowning',
      titleMl: 'മുങ്ങിമരണം',
      titleHi: 'डूबना',
      titleTa: 'நீரில் மூழ்குதல்',
      titleKn: 'ಮುಳುಗುವಿಕೆ',
      steps: [
        'Call 108 immediately',
        'Remove the person from water',
        'Check for breathing',
        'If not breathing, begin CPR',
        'Keep the person warm',
      ],
      stepsMl: [
        'ഉടൻ 108 വിളിക്കുക',
        'വ്യക്തിയെ വെള്ളത്തിൽ നിന്ന് പുറത്തെടുക്കുക',
        'ശ്വാസം ഉണ്ടോ എന്ന് പരിശോധിക്കുക',
        'ശ്വാസമില്ലെങ്കിൽ CPR ആരംഭിക്കുക',
        'വ്യക്തിയെ ചൂടായി സൂക്ഷിക്കുക',
      ],
      stepsHi: [
        'तुरंत 108 पर कॉल करें',
        'व्यक्ति को पानी से बाहर निकालें',
        'सांस चल रही है या नहीं जांचें',
        'अगर सांस नहीं चल रही तो CPR शुरू करें',
        'व्यक्ति को गर्म रखें',
      ],
      stepsTa: [
        'உடனடியாக 108 அழைக்கவும்',
        'நபரை நீரிலிருந்து வெளியே எடுங்கள்',
        'மூச்சு இருக்கிறதா என்று பாருங்கள்',
        'மூச்சு இல்லாவிட்டால் CPR தொடங்குங்கள்',
        'நபரை சூடாக வையுங்கள்',
      ],
      stepsKn: [
        'ತಕ್ಷಣ 108 ಗೆ ಕರೆ ಮಾಡಿ',
        'ವ್ಯಕ್ತಿಯನ್ನು ನೀರಿನಿಂದ ಹೊರತೆಗೆಯಿರಿ',
        'ಉಸಿರಾಟ ಇದೆಯೇ ಪರಿಶೀಲಿಸಿ',
        'ಉಸಿರಾಟ ಇಲ್ಲದಿದ್ದರೆ CPR ಪ್ರಾರಂಭಿಸಿ',
        'ವ್ಯಕ್ತಿಯನ್ನು ಬೆಚ್ಚಗಿಡಿ',
      ],
    ),
    FirstAidStep(
      title: 'Heat Stroke',
      titleMl: 'സൂര്യാഘാതം',
      titleHi: 'लू लगना',
      titleTa: 'வெப்ப அயர்ச்சி',
      titleKn: 'ಬಿಸಿಲು ಹೊಡೆತ',
      steps: [
        'Move to a cool, shaded area',
        'Remove excess clothing',
        'Apply cool water to skin',
        'Fan the person',
        'Give small sips of cool water if conscious',
        'Call 108 if temperature exceeds 40°C',
      ],
      stepsMl: [
        'തണുത്ത, തണലുള്ള സ്ഥലത്തേക്ക് മാറ്റുക',
        'അധിക വസ്ത്രങ്ങൾ നീക്കം ചെയ്യുക',
        'ചർമ്മത്തിൽ തണുത്ത വെള്ളം ഒഴിക്കുക',
        'വ്യക്തിക്ക് വിശറി വീശുക',
        'ബോധമുണ്ടെങ്കിൽ തണുത്ത വെള്ളം ചെറുതായി നൽകുക',
        'ശരീര താപനില 40°C കവിഞ്ഞാൽ 108 വിളിക്കുക',
      ],
      stepsHi: [
        'ठंडी, छायादार जगह पर ले जाएं',
        'अतिरिक्त कपड़े उतारें',
        'त्वचा पर ठंडा पानी लगाएं',
        'व्यक्ति को पंखा करें',
        'अगर होश में हो तो ठंडे पानी की छोटी घूंट दें',
        'अगर तापमान 40°C से अधिक हो तो 108 पर कॉल करें',
      ],
      stepsTa: [
        'குளிர்ச்சியான, நிழலான இடத்திற்கு நகர்த்துங்கள்',
        'அதிகப்படியான ஆடைகளை அகற்றுங்கள்',
        'தோலில் குளிர்ந்த நீர் ஊற்றுங்கள்',
        'நபருக்கு விசிறி வீசுங்கள்',
        'நினைவிருந்தால் சிறிது குளிர்ந்த நீர் கொடுங்கள்',
        'வெப்பநிலை 40°C மேல் சென்றால் 108 அழைக்கவும்',
      ],
      stepsKn: [
        'ತಂಪಾದ, ನೆರಳಿನ ಸ್ಥಳಕ್ಕೆ ಸ್ಥಳಾಂತರಿಸಿ',
        'ಹೆಚ್ಚುವರಿ ಬಟ್ಟೆ ತೆಗೆಯಿರಿ',
        'ಚರ್ಮಕ್ಕೆ ತಣ್ಣೀರು ಹಾಕಿ',
        'ವ್ಯಕ್ತಿಗೆ ಗಾಳಿ ಬೀಸಿ',
        'ಪ್ರಜ್ಞೆ ಇದ್ದರೆ ಸ್ವಲ್ಪ ತಣ್ಣೀರು ಕುಡಿಸಿ',
        'ತಾಪಮಾನ 40°C ಮೀರಿದರೆ 108 ಗೆ ಕರೆ ಮಾಡಿ',
      ],
    ),
    FirstAidStep(
      title: 'Snake Bite',
      titleMl: 'പാമ്പ് കടി',
      titleHi: 'सांप का काटना',
      titleTa: 'பாம்பு கடி',
      titleKn: 'ಹಾವು ಕಡಿತ',
      steps: [
        'Call 108 immediately',
        'Keep the person calm and still',
        'Remove jewelry near the bite',
        'Keep the bite area below heart level',
        'Do NOT cut, suck, or apply tourniquet',
        'Get to a hospital with antivenom',
      ],
      stepsMl: [
        'ഉടൻ 108 വിളിക്കുക',
        'വ്യക്തിയെ ശാന്തമായി അനങ്ങാതെ ഇരുത്തുക',
        'കടിയ്ക്കടുത്തുള്ള ആഭരണങ്ങൾ നീക്കം ചെയ്യുക',
        'കടിച്ച ഭാഗം ഹൃദയത്തിന് താഴെ വയ്ക്കുക',
        'മുറിക്കുകയോ ഊറ്റുകയോ ടൂർണിക്കറ്റ് ഇടുകയോ ചെയ്യരുത്',
        'ആന്റിവെനം ഉള്ള ആശുപത്രിയിൽ എത്തിക്കുക',
      ],
      stepsHi: [
        'तुरंत 108 पर कॉल करें',
        'व्यक्ति को शांत और स्थिर रखें',
        'काटने के पास के गहने उतारें',
        'काटने वाली जगह को दिल के नीचे रखें',
        'काटें नहीं, चूसें नहीं, टूर्निकेट न लगाएं',
        'एंटीवेनम वाले अस्पताल ले जाएं',
      ],
      stepsTa: [
        'உடனடியாக 108 அழைக்கவும்',
        'நபரை அமைதியாகவும் அசையாமலும் வையுங்கள்',
        'கடி அருகிலுள்ள நகைகளை அகற்றுங்கள்',
        'கடிபட்ட இடத்தை இதயத்திற்குக் கீழே வையுங்கள்',
        'வெட்டவோ, உறிஞ்சவோ, டூர்னிக்கெட் போடவோ வேண்டாம்',
        'ஆன்டிவெனம் உள்ள மருத்துவமனைக்குச் செல்லுங்கள்',
      ],
      stepsKn: [
        'ತಕ್ಷಣ 108 ಗೆ ಕರೆ ಮಾಡಿ',
        'ವ್ಯಕ್ತಿಯನ್ನು ಶಾಂತವಾಗಿ ಮತ್ತು ಸ್ಥಿರವಾಗಿ ಇರಿಸಿ',
        'ಕಡಿತದ ಬಳಿಯ ಆಭರಣಗಳನ್ನು ತೆಗೆಯಿರಿ',
        'ಕಡಿತದ ಸ್ಥಳವನ್ನು ಹೃದಯಕ್ಕಿಂತ ಕೆಳಗೆ ಇಡಿ',
        'ಕತ್ತರಿಸಬೇಡಿ, ಹೀರಬೇಡಿ, ಟೂರ್ನಿಕೆಟ್ ಹಾಕಬೇಡಿ',
        'ಆಂಟಿವೆನಮ್ ಇರುವ ಆಸ್ಪತ್ರೆಗೆ ಕರೆದೊಯ್ಯಿರಿ',
      ],
    ),
    FirstAidStep(
      title: 'Severe Bleeding',
      titleMl: 'കഠിനമായ രക്തസ്രാവം',
      titleHi: 'गंभीर रक्तस्राव',
      titleTa: 'கடுமையான இரத்தப்போக்கு',
      titleKn: 'ತೀವ್ರ ರಕ್ತಸ್ರಾವ',
      steps: [
        'Call 108 if bleeding is severe',
        'Apply firm pressure with a clean cloth',
        'Do not remove the cloth — add more layers',
        'Elevate the injured area above the heart',
        'Keep the person lying down',
      ],
      stepsMl: [
        'രക്തസ്രാവം കഠിനമാണെങ്കിൽ 108 വിളിക്കുക',
        'ശുചിയായ തുണി ഉപയോഗിച്ച് ബലമായി അമർത്തുക',
        'തുണി നീക്കം ചെയ്യരുത് — കൂടുതൽ പാളികൾ ചേർക്കുക',
        'പരിക്കേറ്റ ഭാഗം ഹൃദയത്തിന് മുകളിൽ ഉയർത്തുക',
        'വ്യക്തിയെ കിടത്തുക',
      ],
      stepsHi: [
        'अगर रक्तस्राव गंभीर हो तो 108 पर कॉल करें',
        'साफ कपड़े से मजबूती से दबाएं',
        'कपड़ा न हटाएं — और परतें जोड़ें',
        'घायल हिस्से को दिल से ऊपर उठाएं',
        'व्यक्ति को लेटा कर रखें',
      ],
      stepsTa: [
        'இரத்தப்போக்கு கடுமையாக இருந்தால் 108 அழைக்கவும்',
        'சுத்தமான துணியால் உறுதியாக அழுத்துங்கள்',
        'துணியை அகற்றாதீர்கள் — மேலும் அடுக்குகள் சேருங்கள்',
        'காயமடைந்த பகுதியை இதயத்திற்கு மேலே உயர்த்துங்கள்',
        'நபரை படுக்க வையுங்கள்',
      ],
      stepsKn: [
        'ರಕ್ತಸ್ರಾವ ತೀವ್ರವಾಗಿದ್ದರೆ 108 ಗೆ ಕರೆ ಮಾಡಿ',
        'ಶುದ್ಧ ಬಟ್ಟೆಯಿಂದ ಗಟ್ಟಿಯಾಗಿ ಒತ್ತಿ ಹಿಡಿಯಿರಿ',
        'ಬಟ್ಟೆ ತೆಗೆಯಬೇಡಿ — ಹೆಚ್ಚಿನ ಪದರಗಳನ್ನು ಸೇರಿಸಿ',
        'ಗಾಯಗೊಂಡ ಭಾಗವನ್ನು ಹೃದಯಕ್ಕಿಂತ ಮೇಲೆ ಎತ್ತಿ ಹಿಡಿಯಿರಿ',
        'ವ್ಯಕ್ತಿಯನ್ನು ಮಲಗಿಸಿ',
      ],
    ),
  ];
}

/// A single pre-translated medical phrase.
class OfflinePhrase {
  final String category;
  final String english;
  final String malayalam;
  final String hindi;
  final String tamil;
  final String kannada;

  const OfflinePhrase({
    required this.category,
    required this.english,
    required this.malayalam,
    required this.hindi,
    required this.tamil,
    required this.kannada,
  });

  /// Get translation for a given language name.
  String getTranslation(String language) {
    switch (language) {
      case 'Malayalam':
        return malayalam;
      case 'Hindi':
        return hindi;
      case 'Tamil':
        return tamil;
      case 'Kannada':
        return kannada;
      default:
        return english;
    }
  }
}

/// A structured first aid instruction set with multi-language support.
class FirstAidStep {
  final String title;
  final String titleMl;
  final String titleHi;
  final String titleTa;
  final String titleKn;
  final List<String> steps;
  final List<String> stepsMl;
  final List<String> stepsHi;
  final List<String> stepsTa;
  final List<String> stepsKn;

  const FirstAidStep({
    required this.title,
    required this.titleMl,
    required this.titleHi,
    required this.titleTa,
    required this.titleKn,
    required this.steps,
    required this.stepsMl,
    required this.stepsHi,
    required this.stepsTa,
    required this.stepsKn,
  });

  /// Get title in the given language.
  String getTitle(String language) {
    switch (language) {
      case 'Malayalam':
        return titleMl;
      case 'Hindi':
        return titleHi;
      case 'Tamil':
        return titleTa;
      case 'Kannada':
        return titleKn;
      default:
        return title;
    }
  }

  /// Get steps in the given language.
  List<String> getSteps(String language) {
    switch (language) {
      case 'Malayalam':
        return stepsMl;
      case 'Hindi':
        return stepsHi;
      case 'Tamil':
        return stepsTa;
      case 'Kannada':
        return stepsKn;
      default:
        return steps;
    }
  }
}

/// Emergency contact with multi-language label support.
class EmergencyContact {
  final String number;
  final String english;
  final String malayalam;
  final String hindi;
  final String tamil;
  final String kannada;

  const EmergencyContact({
    required this.number,
    required this.english,
    required this.malayalam,
    required this.hindi,
    required this.tamil,
    required this.kannada,
  });

  /// Get label in the given language.
  String getLabel(String language) {
    switch (language) {
      case 'Malayalam':
        return malayalam;
      case 'Hindi':
        return hindi;
      case 'Tamil':
        return tamil;
      case 'Kannada':
        return kannada;
      default:
        return english;
    }
  }
}

