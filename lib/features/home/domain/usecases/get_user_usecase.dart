import '../models/user_model.dart';
import '../../data/repositories/home_repository.dart';

class GetUserUseCase {
  final HomeRepository _repository;

  GetUserUseCase(this._repository);

  Future<UserModel> execute() async {
    return await _repository.getCurrentUser();
  }
}
