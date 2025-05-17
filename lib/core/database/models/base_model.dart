abstract class BaseModel {
  int? id;
  DateTime createdAt;
  DateTime updatedAt;

  BaseModel({
    this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap();
  
  @override
  String toString() {
    return 'BaseModel{id: $id, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}