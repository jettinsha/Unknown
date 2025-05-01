import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/galaxy_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MemoryOrbsApp());
}

class MemoryOrbsApp extends StatelessWidget {
  const MemoryOrbsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Orbs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF9C27B0),
          secondary: Color(0xFFE1BEE7),
          surface: Color(0xFF1A1A1A),
          background: Color(0xFF000000),
        ),
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ),
      home: const GalaxyScreen(),
    );
  }
}
