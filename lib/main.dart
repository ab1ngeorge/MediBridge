import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home_screen.dart';

/// Entry point for MediBridge – Medical Language Assistant.
/// Loads environment variables and launches the app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load API key from .env file
  await dotenv.load(fileName: '.env');

  runApp(const MediBridgeApp());
}

/// Root widget with hospital-style theme.
class MediBridgeApp extends StatelessWidget {
  const MediBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediBridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Clean, hospital-style color scheme
        primaryColor: const Color(0xFF2C5F8A),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A90D9),
          brightness: Brightness.light,
        ),
        // Large, readable text theme
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Color(0xFF1A1A2E)),
          bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF1A1A2E)),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        // High contrast buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A90D9),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
