import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/workout_model.dart';
import 'exercise_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<WorkoutModel> workoutBox;

  @override
  void initState() {
    super.initState();
    workoutBox = Hive.box<WorkoutModel>('workouts');
  }

  void _addWorkout() {
    final id = const Uuid().v4();
    final workout = WorkoutModel(
      id: id,
      name: 'TREINOX', // Nome inicial futurista
      exercises: [],
    );
    workoutBox.put(id, workout);
    setState(() {});
  }

  void _editWorkout(WorkoutModel workout) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExercisePage(
          workout: workout,
          onSave: () async {
            await workout.save();
          },
        ),
      ),
    ).then((_) => setState(() {}));
  }

  void _deleteWorkout(String id) {
    workoutBox.delete(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final workouts = workoutBox.values.toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0D), // Fundo escuro futurista
      appBar: AppBar(
        title: const Text('TREINOX',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: const Color(0xFF0A0A0D),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _addWorkout,
            icon: const Icon(Icons.add_circle_outline),
            color: const Color(0xFF00E5FF),
            iconSize: 32,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final w = workouts[index];
            return GestureDetector(
              onTap: () => _editWorkout(w),
              child: Card(
                color: const Color(0xFF1C1C1E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 4,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  title: Text(
                    w.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  subtitle: Text(
                    '${w.exercises.length} exercícios',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.redAccent,
                    onPressed: () => _deleteWorkout(w.id),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
