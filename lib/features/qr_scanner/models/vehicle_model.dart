class VehicleModel {
  final String id;
  final String ownerName;
  final String plateNumber;
  final String vehicleModel;
  final String status;
  final String vehicleColor;
  final String department;
  final String schoolID;
  final String gender;
  final String yearLevel;
  final String block;
  final String contact;
  final String purok;
  final String barangay;
  final String city;
  final String province;

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
    required this.yearLevel,
    required this.block,
    required this.contact,
    required this.purok,
    required this.barangay,
    required this.city,
    required this.province,
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
      purok: data['purok'] ?? '',
      yearLevel: data['yearLevel'] ?? '',
      block: data['block'] ?? '',
      contact: data['contact'] ?? '',
      barangay: data['barangay'] ?? '',
      city: data['city'] ?? '',
      province: data['province'] ?? '',
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
      'purok': purok,
      'yearLevel': yearLevel,
      'block': block,
      'contact': contact,
      'barangay': barangay,
      'city': city,
      'province': province,
    };
  }
}
