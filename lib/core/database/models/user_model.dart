class UserModel {
  final int? id;
  final String username;
  final DateTime lastLogin;
  final Map<String, dynamic> settings;

  UserModel({
    this.id,
    required this.username,
    required this.lastLogin,
    required this.settings,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      lastLogin: DateTime.parse(map['last_login']),
      settings: map['settings'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'last_login': lastLogin.toUtc().toString(),
      'settings': settings,
    };
  }
}