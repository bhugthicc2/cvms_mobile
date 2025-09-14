import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle_model.dart';
import '../models/vehicle_log_model.dart';

class VehicleRepository {
  final _db = FirebaseFirestore.instance;

  /// Get vehicle by its document ID
  Future<VehicleModel?> getVehicleById(String id) async {
    final doc = await _db.collection('vehicles').doc(id).get();
    if (!doc.exists) return null;
    return VehicleModel.fromMap(doc.data()!, doc.id);
  }

  /// Start a vehicle session (entry scan)
  Future<void> startSession(VehicleModel vehicle, String updatedBy) async {
    final logRef = _db.collection('vehicle_logs').doc();

    final log = VehicleLogModel(
      id: logRef.id,
      vehicleId: vehicle.id,
      ownerName: vehicle.ownerName,
      plateNumber: vehicle.plateNumber,
      vehicleModel: vehicle.vehicleModel,
      timeIn: DateTime.now(),
      updatedBy: updatedBy,
      status: "inside",
    );

    await _db.runTransaction((txn) async {
      // 1. Add log
      txn.set(logRef, log.toMap());

      // 2. Update vehicle status
      txn.update(_db.collection('vehicles').doc(vehicle.id), {
        'status': 'inside',
      });
    });
  }

  /// End a vehicle session (exit scan)
  Future<void> endSession(VehicleModel vehicle, String updatedBy) async {
    // Find active session (timeOut == null)
    final query =
        await _db
            .collection('vehicle_logs')
            .where('vehicleId', isEqualTo: vehicle.id)
            .where('timeOut', isNull: true)
            .limit(1)
            .get();

    if (query.docs.isEmpty) throw Exception("No active session found");

    final logDoc = query.docs.first;

    final timeIn = (logDoc['timeIn'] as Timestamp).toDate();
    final timeOut = DateTime.now();
    final durationMinutes = timeOut.difference(timeIn).inMinutes;

    await _db.runTransaction((txn) async {
      // 1. Update log
      txn.update(logDoc.reference, {
        'timeOut': timeOut,
        'durationMinutes': durationMinutes,
        'status': 'outside',
      });

      // 2. Update vehicle status
      txn.update(_db.collection('vehicles').doc(vehicle.id), {
        'status': 'outside',
      });
    });
  }
}
