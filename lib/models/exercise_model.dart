import 'package:hive/hive.dart';
part 'exercise_model.g.dart';

@HiveType(typeId: 1)
class ExerciseModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int sets;

  @HiveField(3)
  double weight;

  @HiveField(4)
  int restSeconds;

  @HiveField(5)
  String executionLink;

  ExerciseModel({
    required this.id,
    required this.name,
    this.sets = 3,
    this.weight = 0.0,
    this.restSeconds = 60,
    this.executionLink = '',
  });
}
