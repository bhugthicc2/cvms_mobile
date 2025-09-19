class ActivityModel {
  final String id;
  final String vehicleId;
  final String action;
  final String updatedBy;
  final DateTime timestamp;
  final Map<String, dynamic>? additionalData;

  ActivityModel({
    required this.id,
    required this.vehicleId,
    required this.action,
    required this.updatedBy,
    required this.timestamp,
    this.additionalData,
  });

  Map<String, dynamic> toMap() {
    return {
      'vehicleId': vehicleId,
      'action': action,
      'updatedBy': updatedBy,
      'timestamp': timestamp.toIso8601String(),
      'additionalData': additionalData ?? {},
    };
  }

  factory ActivityModel.fromMap(String id, Map<String, dynamic> map) {
    return ActivityModel(
      id: id,
      vehicleId: map['vehicleId'] as String,
      action: map['action'] as String,
      updatedBy: map['updatedBy'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      additionalData: map['additionalData'] as Map<String, dynamic>?,
    );
  }
}
