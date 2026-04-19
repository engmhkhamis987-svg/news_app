import 'package:hive_ce_flutter/adapters.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String? countryCode;
  @HiveField(4)
  final String? countryName;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.countryCode,
    this.countryName,
  });

  UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      countryCode: map['countryCode'],
      countryName: map['countryName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'countryCode': countryCode,
      'countryName': countryName,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? countryCode,
    String? countryName,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: $password, countryCode: $countryCode, countryName: $countryName)';
  }
}
