import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/vehicle_logs_repository.dart';
import 'vehicle_stats_state.dart';

class VehicleStatsCubit extends Cubit<VehicleStatsState> {
  final VehicleLogsRepository repository;
  StreamSubscription? _sub;

  VehicleStatsCubit(this.repository) : super(VehicleStatsInitial());

  void watchVehicleStats() {
    emit(VehicleStatsLoading());
    _sub?.cancel();
    _sub = repository.watchVehicleStatsForToday().listen(
      (data) {
        emit(VehicleStatsLoaded(data));
      },
      onError: (e) {
        emit(VehicleStatsError(e.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
