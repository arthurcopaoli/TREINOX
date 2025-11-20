
import 'package:flutter/material.dart';
import '../data/capsules_data.dart';

class ExercisePage extends StatelessWidget {
  final Exercise exercise;
  const ExercisePage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(exercise.imageUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              exercise.description,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
