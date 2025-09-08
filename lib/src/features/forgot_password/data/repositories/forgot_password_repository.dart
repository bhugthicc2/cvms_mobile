import '../models/forgot_password_response.dart';

abstract class ForgotPasswordRepository {
  Future<ForgotPasswordResponse> sendResetEmail(String email);
}

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  @override
  Future<ForgotPasswordResponse> sendResetEmail(String email) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // For demo purposes, always return success
    // In a real app, this would make an actual API call
    return ForgotPasswordResponse(
      success: true,
      message: 'Password reset email sent successfully',
    );
  }
}
