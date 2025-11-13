import 'package:flutter/material.dart';
import 'exercise_page.dart';

class CapsulePage extends StatelessWidget {
  final Map<String, dynamic> capsule;

  const CapsulePage({super.key, required this.capsule});

  @override
  Widget build(BuildContext context) {
    final exercises = capsule['exercises'] as List;

    return Scaffold(
      backgroundColor: const Color(0xff0a0a0f),
      appBar: AppBar(
        title: Text(capsule['title']),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            color: const Color(0xff1b1b25),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(exercise['name'],
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(
                'Séries: ${exercise['series']} | Peso: ${exercise['weight']}kg | Descanso: ${exercise['rest']}s',
                style: const TextStyle(color: Colors.white70),
              ),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.cyanAccent),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExercisePage(exercise: exercise),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
