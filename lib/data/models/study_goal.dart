import 'package:hive/hive.dart';

part 'study_goal.g.dart';

@HiveType(typeId: 0)
class StudyGoal extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double progress; // 0.0 to 1.0

  StudyGoal({required this.id, required this.title, this.progress = 0.0});
}
