import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String name;
  final String lastName;
  final String nickname;
  final String email;
  final DateTime birthDate;

  const UserData({
    required this.name,
    required this.lastName,
    required this.nickname,
    required this.email,
    required this.birthDate,
  });

  UserData.fromJson(Map<String, dynamic> json)
    : name = json['name'] ?? '',
      lastName = json['lastName'] ?? '',
      nickname = json['nickname'] ?? '',
      email = json['email'] ?? '',
      birthDate = (json['birthDate'] as Timestamp?)?.toDate() ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'name': name,
    'lastName': lastName,
    'nickname': nickname,
    'email': email,
    'birthDate': Timestamp.fromDate(birthDate),
  };
}
