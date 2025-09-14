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
