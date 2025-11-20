// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

class WorkoutModelAdapter extends TypeAdapter<WorkoutModel> {
  @override
  final int typeId = 0;

  @override
  WorkoutModel read(BinaryReader reader) {
    return WorkoutModel(
      id: reader.read(),
      name: reader.read(),
      exercises: (reader.read() as List).cast<ExerciseModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutModel obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.exercises);
  }
}
