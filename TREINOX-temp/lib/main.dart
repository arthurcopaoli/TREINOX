
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const DiversGymApp());
}

class DiversGymApp extends StatelessWidget {
  const DiversGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiversGYM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomePage(),
    );
  }
}
