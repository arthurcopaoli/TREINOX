// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

class ExerciseModelAdapter extends TypeAdapter<ExerciseModel> {
  @override
  final int typeId = 1;

  @override
  ExerciseModel read(BinaryReader reader) {
    return ExerciseModel(
      id: reader.read(),
      name: reader.read(),
      sets: reader.read(),
      weight: reader.read(),
      restSeconds: reader.read(),
      executionLink: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseModel obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.sets);
    writer.write(obj.weight);
    writer.write(obj.restSeconds);
    writer.write(obj.executionLink);
  }
}
