import 'package:cvms_mobile/features/qr_scanner/bloc/vehicle_scan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/vehicle_repository.dart';
// crypto service
import 'package:cvms_mobile/core/services/crypto_service.dart';

class VehicleScanCubit extends Cubit<VehicleScanState> {
  final VehicleRepository repo;

  VehicleScanCubit(this.repo) : super(VehicleScanInitial());

  Future<void> processEntryScan(String qrValue, String updatedBy) async {
    emit(VehicleScanLoading());
    try {
      final vehicleDocId = await Future(
        () => CryptoService.withDefaultKey().decryptVehicleId(qrValue),
      ); //decrypt the scanned qr value with default key
      await repo.handleEntryScan(
        vehicleDocId: vehicleDocId,
        updatedBy: updatedBy,
      );

      emit(VehicleScanSuccess("Vehicle entered successfully"));
    } catch (e) {
      emit(VehicleScanError("Entry scan failed: ${e.toString()}"));
    }
  }

  Future<void> processExitScan(String qrValue, String updatedBy) async {
    emit(VehicleScanLoading());
    try {
      final vehicleDocId = await Future(
        () => CryptoService.withDefaultKey().decryptVehicleId(qrValue),
      ); //decrypt the scanned qr value with default key
      await repo.handleExitScan(
        vehicleDocId: vehicleDocId,
        updatedBy: updatedBy,
      );

      emit(VehicleScanSuccess("Vehicle exited successfully"));
    } catch (e) {
      emit(VehicleScanError("Exit scan failed: ${e.toString()}"));
    }
  }

  Future<void> getVehicleById(String qrValue) async {
    emit(VehicleScanLoading());
    try {
      final vehicleId = await Future(
        () => CryptoService.withDefaultKey().decryptVehicleId(qrValue),
      ); //decrypt the scanned qr value with default key

      final vehicle = await repo.getVehicleById(vehicleId);

      if (vehicle != null) {
        emit(VehicleRetrieved(vehicle));
      } else {
        emit(VehicleScanError("Vehicle not found"));
      }
    } catch (e) {
      emit(VehicleScanError("Scan failed: ${e.toString()}"));
    }
  }
}
