import 'base_model.dart';

class FinanceModel extends BaseModel {
  final int userId;
  final String type;
  final double amount;
  final String category;
  final String? description;
  final DateTime date;

  FinanceModel({
    super.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.category,
    this.description,
    required this.date,
    required super.createdAt,
    required super.updatedAt,
  });

  factory FinanceModel.fromMap(Map<String, dynamic> map) {
    return FinanceModel(
      id: map['id'],
      userId: map['user_id'],
      type: map['type'],
      amount: map['amount'],
      category: map['category'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date.toUtc().toString(),
      'created_at': createdAt.toUtc().toString(),
      'updated_at': updatedAt.toUtc().toString(),
    };
  }
}