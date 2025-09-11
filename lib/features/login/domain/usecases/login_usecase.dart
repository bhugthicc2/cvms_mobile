import '../../data/models/login_request.dart';
import '../../data/models/login_response.dart';
import '../../data/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  Future<LoginResponse> execute(LoginRequest request) async {
    return await _repository.login(request);
  }
}
