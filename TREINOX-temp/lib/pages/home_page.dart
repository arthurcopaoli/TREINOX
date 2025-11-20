
import 'package:flutter/material.dart';
import '../data/capsules_data.dart';
import 'capsule_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DiversGYM")),
      body: ListView.builder(
        itemCount: capsules.length,
        itemBuilder: (context, index) {
          final capsule = capsules[index];
          return ListTile(
            title: Text(capsule.title),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CapsulePage(capsule: capsule),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
