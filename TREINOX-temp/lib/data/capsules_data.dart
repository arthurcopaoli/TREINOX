
class Exercise {
  final String name;
  final String imageUrl;
  final String description;

  Exercise({
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}

class Capsule {
  final String title;
  final List<Exercise> exercises;

  Capsule({required this.title, required this.exercises});
}

final capsules = [
  Capsule(
    title: "Semana 1 - Cápsula 1",
    exercises: [
      Exercise(
        name: "Supino Reto",
        imageUrl: "https://via.placeholder.com/300x200",
        description: "Deite no banco, segure a barra com as mãos afastadas e desça até o peito.",
      ),
      Exercise(
        name: "Agachamento Livre",
        imageUrl: "https://via.placeholder.com/300x200",
        description: "Mantenha a postura ereta e desça até 90° no joelho.",
      ),
    ],
  ),
  Capsule(
    title: "Semana 1 - Cápsula 2",
    exercises: [
      Exercise(
        name: "Remada Curvada",
        imageUrl: "https://via.placeholder.com/300x200",
        description: "Segure a barra e puxe em direção ao abdômen.",
      ),
    ],
  ),
];
