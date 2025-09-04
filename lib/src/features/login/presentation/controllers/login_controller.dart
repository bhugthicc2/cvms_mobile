import 'package:flutter/material.dart';
import '../../data/models/login_request.dart';
import '../../data/models/login_response.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginController extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginController(this._loginUseCase);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool keepLoggedIn = false;
  bool isPasswordVisible = false;
  bool isLoading = false;
  String? errorMessage;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleKeepLoggedIn() {
    keepLoggedIn = !keepLoggedIn;
    notifyListeners();
  }

  Future<LoginResponse?> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      errorMessage = 'Please fill in all fields';
      notifyListeners();
      return null;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final request = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
        keepLoggedIn: keepLoggedIn,
      );

      final response = await _loginUseCase.execute(request);

      isLoading = false;
      notifyListeners();

      if (!response.success) {
        errorMessage = response.message ?? 'Invalid credentials';
        notifyListeners();
      }

      return response;
    } catch (e) {
      isLoading = false;
      errorMessage = 'Login failed. Please try again.';
      notifyListeners();
      return null;
    }
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
