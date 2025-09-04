import '../../data/repositories/home_repository.dart';

class LogoutUseCase {
  final HomeRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> execute() async {
    return await _repository.logout();
  }
}
