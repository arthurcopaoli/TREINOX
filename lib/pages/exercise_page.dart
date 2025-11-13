import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExercisePage extends StatefulWidget {
  final Map<String, dynamic> exercise;

  const ExercisePage({super.key, required this.exercise});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late TextEditingController linkController;

  @override
  void initState() {
    super.initState();
    linkController = TextEditingController(text: widget.exercise['link'] ?? '');
  }

  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  void _openLink() async {
    final url = Uri.parse(linkController.text);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Link inválido!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.exercise;

    return Scaffold(
      backgroundColor: const Color(0xff0a0a0f),
      appBar: AppBar(
        title: Text(e['name']),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Séries: ${e['series']}',
                style: const TextStyle(fontSize: 18)),
            Text('Peso: ${e['weight']}kg',
                style: const TextStyle(fontSize: 18)),
            Text('Descanso: ${e['rest']}s',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            const Text('Execução',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: linkController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff1b1b25),
                hintText: 'Cole o link do vídeo aqui...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.cyanAccent),
                  onPressed: _openLink,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
