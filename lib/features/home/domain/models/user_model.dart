class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? profileImage;
  final String role;
  final String status;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.profileImage,
    required this.role,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullname'] ?? '',
      profileImage: json['profile_image'],
      role: json['role'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullname': fullName,
      'profile_image': profileImage,
      'role': role,
      'status': status,
    };
  }
}
