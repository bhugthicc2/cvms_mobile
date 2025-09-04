import '../../domain/models/user_model.dart';
import '../../domain/models/statistics_model.dart';

abstract class HomeRepository {
  Future<UserModel> getCurrentUser();
  Future<StatisticsModel> getStatistics();
  Future<void> logout();
}

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<UserModel> getCurrentUser() async {
    // TODO: Get current user from shared preferences or Firebase Auth
    // For now, return a mock user
    await Future.delayed(const Duration(milliseconds: 500));

    return const UserModel(
      id: '1',
      email: 'juan.delacruz@example.com',
      fullName: 'Juan Dela Cruz',
      role: 'admin',
      status: 'active',
    );
  }

  @override
  Future<StatisticsModel> getStatistics() async {
    // TODO: Fetch statistics from Firestore
    // For now, return mock data
    await Future.delayed(const Duration(milliseconds: 800));

    return const StatisticsModel(
      entered: 45,
      exited: 75,
      others: 180,
      total: 300,
    );
  }

  @override
  Future<void> logout() async {
    // TODO: Implement logout logic
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
