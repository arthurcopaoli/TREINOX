import 'package:hive/hive.dart';
import 'exercise_model.dart';
part 'workout_model.g.dart';

@HiveType(typeId: 0)
class WorkoutModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<ExerciseModel> exercises;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.exercises,
  });
}
