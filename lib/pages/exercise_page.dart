import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/workout_model.dart';
import '../models/exercise_model.dart';

class ExercisePage extends StatefulWidget {
  final WorkoutModel workout;
  final Future<void> Function() onSave;

  const ExercisePage({super.key, required this.workout, required this.onSave});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late List<ExerciseModel> exercises;

  @override
  void initState() {
    super.initState();
    exercises = widget.workout.exercises;
  }

  Future<void> _saveAndReturn() async {
    widget.workout.exercises = exercises;
    await widget.onSave();
    Navigator.pop(context);
  }

  void _addExercise() {
    final id = const Uuid().v4();
    setState(() {
      exercises.add(ExerciseModel(id: id, name: 'Novo exercício'));
    });
  }

  // ------------------------------------------------------------
  // RENOMEAR TREINO
  // ------------------------------------------------------------
  void _renameWorkout() async {
    final controller = TextEditingController(text: widget.workout.name);

    final newName = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        title: const Text(
          'Renomear treino',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(labelText: 'Novo nome'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Salvar',
                style: TextStyle(color: Color(0xFF00E5FF))),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        widget.workout.name = newName;
      });
      await widget.workout.save();
    }
  }

  // ------------------------------------------------------------

  void _editExercise(int index) async {
    final e = exercises[index];
    final res = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) {
        final nameController = TextEditingController(text: e.name);
        final setsController = TextEditingController(text: e.sets.toString());
        final weightController =
            TextEditingController(text: e.weight.toString());
        final restController =
            TextEditingController(text: e.restSeconds.toString());
        final linkController = TextEditingController(text: e.executionLink);

        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1E),
          title: const Text('Editar exercício',
              style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _futuristicTextField(nameController, 'Nome'),
                _futuristicTextField(setsController, 'Séries', isNumber: true),
                _futuristicTextField(weightController, 'Peso (kg)',
                    isDecimal: true),
                _futuristicTextField(restController, 'Descanso (s)',
                    isNumber: true),
                _futuristicTextField(linkController, 'Link de execução'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar',
                  style: TextStyle(color: Colors.redAccent)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, {
                'name': nameController.text,
                'sets': int.tryParse(setsController.text) ?? e.sets,
                'weight': double.tryParse(weightController.text) ?? e.weight,
                'rest': int.tryParse(restController.text) ?? e.restSeconds,
                'link': linkController.text,
              }),
              child: const Text('Salvar',
                  style: TextStyle(color: Color(0xFF00E5FF))),
            ),
          ],
        );
      },
    );

    if (res != null) {
      setState(() {
        exercises[index].name = res['name'];
        exercises[index].sets = res['sets'];
        exercises[index].weight = res['weight'];
        exercises[index].restSeconds = res['rest'];
        exercises[index].executionLink = res['link'];
      });
    }
  }

  Widget _futuristicTextField(TextEditingController controller, String label,
      {bool isNumber = false, bool isDecimal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        keyboardType: isNumber
            ? TextInputType.number
            : isDecimal
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFF0A0A0D),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00E5FF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 2),
          ),
        ),
      ),
    );
  }

  void _deleteExercise(int index) {
    setState(() {
      exercises.removeAt(index);
    });
  }

  Future<void> _openLink(String link) async {
    if (link.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Link vazio')));
      return;
    }
    final uri = Uri.parse(link.startsWith('http') ? link : 'https://$link');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0D),

        // ------------ RENOMEAR AO TOCAR NO TÍTULO ------------
        title: GestureDetector(
          onTap: _renameWorkout,
          child: Text(
            widget.workout.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.2,
            ),
          ),
        ),
        // ------------------------------------------------------

        actions: [
          IconButton(
            onPressed: _addExercise,
            icon: const Icon(Icons.add_circle_outline),
            color: const Color(0xFF00E5FF),
            iconSize: 32,
          ),
          IconButton(
            onPressed: _saveAndReturn,
            icon: const Icon(Icons.check_circle_outline),
            color: const Color(0xFF00E5FF),
            iconSize: 32,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ReorderableListView.builder(
          itemCount: exercises.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex -= 1;
              final item = exercises.removeAt(oldIndex);
              exercises.insert(newIndex, item);
            });
          },
          itemBuilder: (context, index) {
            final e = exercises[index];
            return Card(
              key: ValueKey(e.id),
              color: const Color(0xFF1C1C1E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(e.name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Séries: ${e.sets} • Peso: ${e.weight}kg • Desc: ${e.restSeconds}s',
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF00E5FF)),
                  onSelected: (s) {
                    if (s == 'edit') _editExercise(index);
                    if (s == 'delete') _deleteExercise(index);
                    if (s == 'open') _openLink(e.executionLink);
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Editar')),
                    PopupMenuItem(value: 'delete', child: Text('Excluir')),
                    PopupMenuItem(value: 'open', child: Text('Abrir execução')),
                  ],
                ),
                onTap: () => _editExercise(index),
              ),
            );
          },
        ),
      ),
    );
  }
}