import '../models/statistics_model.dart';
import '../../data/repositories/home_repository.dart';

class GetStatisticsUseCase {
  final HomeRepository _repository;

  GetStatisticsUseCase(this._repository);

  Future<StatisticsModel> execute() async {
    return await _repository.getStatistics();
  }
}
