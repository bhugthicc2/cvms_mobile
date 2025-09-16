import '../models/vehicle_model.dart';

abstract class VehicleScanState {}

class VehicleScanInitial extends VehicleScanState {}

class VehicleScanLoading extends VehicleScanState {}

class VehicleScanSuccess extends VehicleScanState {
  final String message;

  VehicleScanSuccess(this.message);
}

class VehicleScanError extends VehicleScanState {
  final String error;
  VehicleScanError(this.error);
}

class VehicleRetrieved extends VehicleScanState {
  final VehicleModel vehicle;
  VehicleRetrieved(this.vehicle);
}
