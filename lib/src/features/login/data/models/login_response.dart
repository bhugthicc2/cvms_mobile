class LoginResponse {
  final bool success;
  final String? token;
  final String? message;
  final User? user;

  const LoginResponse({
    required this.success,
    this.token,
    this.message,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      token: json['token'],
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String? profileImage;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      profileImage: json['profile_image'],
    );
  }
}
