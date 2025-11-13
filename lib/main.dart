import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const TreinoxApp());
}

class TreinoxApp extends StatelessWidget {
  const TreinoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TREINOX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.cyanAccent,
          secondary: Colors.deepPurpleAccent,
          background: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
