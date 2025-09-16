import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String fullname;
  final String email;
  final String role;
  final String status;
  final DateTime? lastLogin;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.role,
    required this.status,
    this.lastLogin,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
      'status': status,
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    DateTime? lastLogin;

    if (map['lastLogin'] != null) {
      if (map['lastLogin'] is String) {
        lastLogin = DateTime.parse(map['lastLogin']);
      } else if (map['lastLogin'] is DateTime) {
        lastLogin = map['lastLogin'];
      } else {
        try {
          if (map['lastLogin'] is Timestamp) {
            lastLogin = (map['lastLogin'] as Timestamp).toDate();
          } else {
            final timestamp = Timestamp.fromDate(
              DateTime.parse(map['lastLogin'].toString()),
            );
            lastLogin = timestamp.toDate();
          }
        } catch (e) {
          lastLogin = null;
        }
      }
    }

    return UserModel(
      id: id,
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'user',
      status: map['status'] ?? 'inactive',
      lastLogin: lastLogin,
    );
  }
}
