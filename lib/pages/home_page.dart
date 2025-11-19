import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/workout_model.dart';
import '../models/exercise_model.dart';
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

  // Função para adicionar novo treino com nome personalizado
  void _addNewWorkout() {
    String workoutName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nome do Treino'),
          content: TextField(
            onChanged: (value) {
              workoutName = value;
            },
            decoration:
                const InputDecoration(hintText: "Digite o nome do treino"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (workoutName.trim().isNotEmpty) {
                  final newWorkout = WorkoutModel(
                    id: const Uuid().v4(),
                    name: workoutName,
                    exercises: [],
                  );
                  workoutBox.add(newWorkout);
                  setState(() {}); // Atualiza a lista na tela
                }
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Deletar treino
  void _deleteWorkout(int index) {
    workoutBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Treinos'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: workoutBox.listenable(),
        builder: (context, Box<WorkoutModel> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text('Nenhum treino criado'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final workout = box.getAt(index);
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: ListTile(
                  title: Text(workout!.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteWorkout(index),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExercisePage(
                          workout: workout,
                          onSave: () async {
                            setState(() {}); // Corrigido: agora é Future<void>
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewWorkout,
        child: const Icon(Icons.add),
      ),
    );
  }
}
