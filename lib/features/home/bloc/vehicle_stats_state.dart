import 'package:cvms_mobile/features/home/models/chart_model.dart';

abstract class VehicleStatsState {}

class VehicleStatsInitial extends VehicleStatsState {}

class VehicleStatsLoading extends VehicleStatsState {}

class VehicleStatsLoaded extends VehicleStatsState {
  final List<ChartModel> chartData;
  VehicleStatsLoaded(this.chartData);
}

class VehicleStatsError extends VehicleStatsState {
  final String message;
  VehicleStatsError(this.message);
}
