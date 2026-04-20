// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudyGoalAdapter extends TypeAdapter<StudyGoal> {
  @override
  final int typeId = 0;

  @override
  StudyGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudyGoal(
      id: fields[0] as String,
      title: fields[1] as String,
      progress: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, StudyGoal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.progress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
