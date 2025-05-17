import 'base_model.dart';

class ProjectModel extends BaseModel {
  final int userId;
  final String title;
  final String? description;
  final DateTime deadline;
  final String status;
  final String priority;

  ProjectModel({
    super.id,
    required this.userId,
    required this.title,
    this.description,
    required this.deadline,
    required this.status,
    required this.priority,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      description: map['description'],
      deadline: DateTime.parse(map['deadline']),
      status: map['status'],
      priority: map['priority'],
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
      'status': status,
      'priority': priority,
      'created_at': createdAt.toUtc().toString(),
      'updated_at': updatedAt.toUtc().toString(),
    };
  }
}