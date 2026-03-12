import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Service that wraps the speech_to_text package for voice recognition.
/// Converts spoken English into text.
class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isInitialized = false;

  /// Whether the speech recognizer is currently listening.
  bool get isListening => _speech.isListening;

  /// Initialize speech recognition. Must be called before startListening.
  /// Returns true if initialization was successful.
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    _isInitialized = await _speech.initialize(
      onError: (error) {
        // Log error silently; UI will handle state
      },
      onStatus: (status) {
        // Status updates handled by listener
      },
    );
    return _isInitialized;
  }

  /// Start listening for speech input.
  ///
  /// [onResult] - Callback that receives recognized text and finality flag.
  /// [localeId] - Locale for speech recognition (default: 'en_US').
  Future<void> startListening({
    required void Function(String text, bool isFinal) onResult,
    String localeId = 'en_US',
  }) async {
    if (!_isInitialized) {
      final success = await initialize();
      if (!success) return;
    }

    await _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords, result.finalResult);
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 5),
      localeId: localeId,
    );
  }

  /// Stop listening for speech input.
  Future<void> stopListening() async {
    await _speech.stop();
  }

  /// Cancel the current listening session.
  Future<void> cancel() async {
    await _speech.cancel();
  }
}
