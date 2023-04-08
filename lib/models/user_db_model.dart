import 'dart:math';

final String UserData = 'userData';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, name, email, password, userId
  ];

  static final String id = '_id';
  static final String userId = 'userId';
  static final String name = 'name';
  static final String email = 'email';
  static final String password = 'password';
  static final String role = 'role';
}

class User {
  final int? id;
  final String userId;
  final String name;
  final String email;
  final String password;
  final String role;

  const User(
      {this.id,
      required this.name,
      required this.email,
      required this.userId,
      required this.password,
      required this.role});

  User copy(
          {int? id,
          String? name,
          String? email,
          String? password,
          String? userId,
          String? role}) =>
      User(
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          userId: userId ?? this.userId,
          role: role ?? this.role);

  static User fromJson(Map<String, Object?> json) => User(
      id: json[UserFields.id] as int?,
      name: json[UserFields.name] as String,
      email: json[UserFields.email] as String,
      password: json[UserFields.password] as String,
      userId: json[UserFields.userId] as String,
      role: json[UserFields.role] as String);

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.password: password,
        UserFields.userId: userId,
        UserFields.role: role
      };
}
