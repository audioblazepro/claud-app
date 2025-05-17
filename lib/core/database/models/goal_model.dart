import 'base_model.dart';

class GoalModel extends BaseModel {
  final int userId;
  final String title;
  final String? description;
  final DateTime deadline;
  final double progress;
  final String status;

  GoalModel({
    super.id,
    required this.userId,
    required this.title,
    this.description,
    required this.deadline,
    required this.progress,
    required this.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      description: map['description'],
      deadline: DateTime.parse(map['deadline']),
      progress: map['progress'],
      status: map['status'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'deadline': deadline.toUtc().toString(),
      'progress': progress,
      'status': status,
      'created_at': createdAt.toUtc().toString(),
      'updated_at': updatedAt.toUtc().toString(),
    };
  }
}