import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleLogModel {
  final String id;
  final String vehicleId;
  final String ownerName;
  final String plateNumber;
  final String vehicleModel;
  final DateTime timeIn;
  final DateTime? timeOut;
  final String updatedBy;
  final String status;
  final int? durationMinutes;

  VehicleLogModel({
    required this.id,
    required this.vehicleId,
    required this.ownerName,
    required this.plateNumber,
    required this.vehicleModel,
    required this.timeIn,
    this.timeOut,
    required this.updatedBy,
    required this.status,
    this.durationMinutes,
  });

  factory VehicleLogModel.fromMap(Map<String, dynamic> data, String id) {
    return VehicleLogModel(
      id: id,
      vehicleId: data['vehicleId'] ?? '',
      ownerName: data['ownerName'] ?? '',
      plateNumber: data['plateNumber'] ?? '',
      vehicleModel: data['vehicleModel'] ?? '',
      timeIn: (data['timeIn'] as Timestamp).toDate(),
      timeOut:
          data['timeOut'] != null
              ? (data['timeOut'] as Timestamp).toDate()
              : null,
      updatedBy: data['updatedBy'] ?? '',
      status: data['status'] ?? 'outside',
      durationMinutes: data['durationMinutes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicleId': vehicleId,
      'ownerName': ownerName,
      'plateNumber': plateNumber,
      'vehicleModel': vehicleModel,
      'timeIn': timeIn,
      'timeOut': timeOut,
      'updatedBy': updatedBy,
      'status': status,
      'durationMinutes': durationMinutes,
    };
  }
}
