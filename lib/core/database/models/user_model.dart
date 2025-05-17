import 'dart:convert';
import 'base_model.dart';

class UserModel extends BaseModel {
  final String username;
  final DateTime lastLogin;
  final Map<String, dynamic> settings;

  UserModel({
    super.id,
    required this.username,
    required this.lastLogin,
    required this.settings,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      lastLogin: DateTime.parse(map['last_login']),
      settings: jsonDecode(map['settings']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'last_login': lastLogin.toUtc().toString(),
      'settings': jsonEncode(settings),
      'created_at': createdAt.toUtc().toString(),
      'updated_at': updatedAt.toUtc().toString(),
    };
  }

  UserModel copyWith({
    int? id,
    String? username,
    DateTime? lastLogin,
    Map<String, dynamic>? settings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      lastLogin: lastLogin ?? this.lastLogin,
      settings: settings ?? this.settings,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}