import '../../data/models/forgot_password_response.dart';
import '../../data/repositories/forgot_password_repository.dart';

class ForgotPasswordUseCase {
  final ForgotPasswordRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<ForgotPasswordResponse> sendResetEmail(String email) async {
    return await _repository.sendResetEmail(email);
  }
}
