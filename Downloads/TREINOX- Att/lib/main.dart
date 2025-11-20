import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/workout_model.dart';
import 'models/exercise_model.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registrar adapters
  Hive.registerAdapter(WorkoutModelAdapter());
  Hive.registerAdapter(ExerciseModelAdapter());

  await Hive.openBox<WorkoutModel>('workouts');

  runApp(const TreinoxApp());
}

class TreinoxApp extends StatelessWidget {
  const TreinoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TREINOX',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0D),
        primaryColor: const Color(0xFF00E5FF),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF00E5FF),
          secondary: const Color(0xFF0EA5E9),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0A0D),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.2,
          ),
          iconTheme: IconThemeData(color: Color(0xFF00E5FF)),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1C1C1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.grey),
          titleLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF0A0A0D),
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00E5FF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 2),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF00E5FF)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF00E5FF),
          foregroundColor: Colors.black,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF00E5FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
