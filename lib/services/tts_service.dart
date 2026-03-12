import 'package:flutter_tts/flutter_tts.dart';

/// Service that wraps flutter_tts for text-to-speech playback.
/// Supports speaking translated text in Malayalam, Hindi, Bengali, and Tamil.
class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;

  /// Map language names to their TTS locale codes.
  static const Map<String, String> _languageCodes = {
    'Malayalam': 'ml-IN',
    'Hindi': 'hi-IN',
    'Bengali': 'bn-IN',
    'Tamil': 'ta-IN',
    'Kannada': 'kn-IN',
    'Tulu': 'kn-IN',          // Tulu uses Kannada TTS (closest)
    'Konkani': 'kn-IN',       // Konkani uses Kannada TTS (closest)
    'Beary (Beary Bashe)': 'ml-IN', // Beary uses Malayalam TTS (closest)
    'Marathi': 'mr-IN',
    'Urdu': 'ur-IN',
  };

  /// Initialize TTS engine with default settings.
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _tts.setSpeechRate(0.45); // Slower for clarity
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _isInitialized = true;
  }

  /// Speak the given text in the specified language.
  ///
  /// [text] - The text to speak aloud.
  /// [language] - The language name (e.g., "Malayalam").
  Future<void> speak(String text, String language) async {
    if (!_isInitialized) await initialize();

    final langCode = _languageCodes[language] ?? 'en-US';
    await _tts.setLanguage(langCode);
    await _tts.speak(text);
  }

  /// Stop any ongoing speech.
  Future<void> stop() async {
    await _tts.stop();
  }
}
