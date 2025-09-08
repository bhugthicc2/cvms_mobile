import 'package:flutter/material.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../data/models/forgot_password_response.dart';

class ForgotPasswordController extends ChangeNotifier {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  ForgotPasswordController(this._forgotPasswordUseCase);

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<ForgotPasswordResponse?> sendResetEmail() async {
    if (emailController.text.trim().isEmpty) {
      return ForgotPasswordResponse(
        success: false,
        message: 'Please enter your email address',
      );
    }

    if (!_isValidEmail(emailController.text.trim())) {
      return ForgotPasswordResponse(
        success: false,
        message: 'Please enter a valid email address',
      );
    }

    setLoading(true);

    try {
      final response = await _forgotPasswordUseCase.sendResetEmail(
        emailController.text.trim(),
      );
      return response;
    } catch (e) {
      return ForgotPasswordResponse(
        success: false,
        message: 'An error occurred. Please try again.',
      );
    } finally {
      setLoading(false);
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
