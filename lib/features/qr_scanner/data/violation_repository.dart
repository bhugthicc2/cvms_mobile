import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvms_mobile/features/activity/data/activity_repository.dart';
import 'package:cvms_mobile/features/activity/models/activity_model.dart';
import 'package:cvms_mobile/features/qr_scanner/models/violation_model.dart';

class ViolationRepository {
  final FirebaseFirestore _db;
  final collection = 'violations';

  ViolationRepository({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  Future<String> reportViolation({
    required String reportedBy,
    required String plateNumber,
    required String vehicleID,
    required String owner,
    required String violation,
  }) async {
    try {
      final violationData = ViolationModel(
        violationID: '',
        dateTime: Timestamp.now(),
        reportedBy: reportedBy,
        plateNumber: plateNumber,
        vehicleID: vehicleID,
        owner: owner,
        violation: violation,
        status: 'pending',
      );

      final docRef = await _db
          .collection(collection)
          .add(violationData.toMap());

      // Record activity
      await ActivityRepository().addActivity(
        ActivityModel(
          id: '',
          vehicleId: vehicleID,
          action: "Violation Report",
          updatedBy: reportedBy,
          timestamp: DateTime.now(),
          additionalData: {
            "plateNumber": plateNumber,
            "owner": owner,
            "violation": violation,
          },
        ),
      );

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to report violation: $e');
    }
  }
}
