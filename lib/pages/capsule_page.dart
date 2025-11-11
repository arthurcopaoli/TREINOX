
import 'package:flutter/material.dart';
import '../data/capsules_data.dart';
import 'exercise_page.dart';

class CapsulePage extends StatelessWidget {
  final Capsule capsule;
  const CapsulePage({super.key, required this.capsule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(capsule.title)),
      body: ListView.builder(
        itemCount: capsule.exercises.length,
        itemBuilder: (context, index) {
          final exercise = capsule.exercises[index];
          return ListTile(
            title: Text(exercise.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExercisePage(exercise: exercise),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
