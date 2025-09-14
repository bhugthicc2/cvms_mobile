class VehicleModel {
  final String id; // Firestore doc ID
  final String ownerName;
  final String plateNumber;
  final String vehicleModel;
  final String status; // "inside" or "outside"

  VehicleModel({
    required this.id,
    required this.ownerName,
    required this.plateNumber,
    required this.vehicleModel,
    required this.status,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> data, String id) {
    return VehicleModel(
      id: id,
      ownerName: data['ownerName'] ?? '',
      plateNumber: data['plateNumber'] ?? '',
      vehicleModel: data['vehicleModel'] ?? '',
      status: data['status'] ?? 'outside',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerName': ownerName,
      'plateNumber': plateNumber,
      'vehicleModel': vehicleModel,
      'status': status,
    };
  }
}
