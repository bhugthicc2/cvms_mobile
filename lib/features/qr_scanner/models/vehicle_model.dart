class VehicleModel {
  final String id; // Firestore doc ID
  final String ownerName;
  final String plateNumber;
  final String vehicleModel;
  final String status; // "inside" or "outside"
  final String vehicleColor;
  final String department;
  final String schoolID;
  final String gender;

  VehicleModel({
    required this.id,
    required this.ownerName,
    required this.plateNumber,
    required this.vehicleModel,
    required this.status,
    required this.vehicleColor,
    required this.department,
    required this.schoolID,
    required this.gender,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> data, String id) {
    return VehicleModel(
      id: id,
      ownerName: data['ownerName'] ?? '',
      plateNumber: data['plateNumber'] ?? '',
      vehicleModel: data['vehicleModel'] ?? '',
      status: data['status'] ?? 'outside',
      vehicleColor: data['vehicleColor'] ?? '',
      department: data['department'] ?? '',
      schoolID: data['schoolID'] ?? '',
      gender: data['gender'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerName': ownerName,
      'plateNumber': plateNumber,
      'vehicleModel': vehicleModel,
      'status': status,
      'vehicleColor': vehicleColor,
      'department': department,
      'schoolID': schoolID,
      'gender': gender,
    };
  }
}
