class LoginRequest {
  final String email;
  final String password;
  final bool keepLoggedIn;

  const LoginRequest({
    required this.email,
    required this.password,
    this.keepLoggedIn = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'keep_logged_in': keepLoggedIn,
    };
  }
}
