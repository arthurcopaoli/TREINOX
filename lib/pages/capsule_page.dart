import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../models/exercise_model.dart';

class CapsulePage extends StatelessWidget {
  final WorkoutModel workout;

  const CapsulePage({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do Treino: ${workout.name}'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workout.exercises.length,
        itemBuilder: (context, index) {
          final e = workout.exercises[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(e.name),
              subtitle: Text(
                  'Séries: ${e.sets} • Peso: ${e.weight}kg • Desc: ${e.restSeconds}s'),
              trailing: IconButton(
                icon: const Icon(Icons.play_circle_fill),
                onPressed: () {
                  if (e.executionLink.isNotEmpty) {
                    // Tenta abrir o link externo
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Abrindo execução: ${e.executionLink}')),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
