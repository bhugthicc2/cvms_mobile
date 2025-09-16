import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle_model.dart';
import '../models/vehicle_log_model.dart';

class VehicleRepository {
  final _db = FirebaseFirestore.instance;

  /// Get vehicle by its document ID
  Future<VehicleModel?> getVehicleById(String id) async {
    // 10 Attempting to fetch vehicle with ID:

    final doc = await _db.collection('vehicles').doc(id).get();

    if (!doc.exists) {
      //vehicle id not found
      return null;
    }
    // 13 Vehicle document found for ID:
    // 14 Vehicle data: {vehicleColor: Red, crNumber: 43t45435r, createdAt: Timestamp(seconds=1757645214, nanoseconds=826000000),
    //ownerName: Jesie Gapol, schoolID: KC-22-A-00266, vehicleModel: Rusi, licenseNumber: 2wdwrwer, orNumber: 35243123, department: College of Computing Studies,
    // plateNumber: E2423443, vehicleType: two-wheeled, status: outside}

    final vehicle = VehicleModel.fromMap(doc.data()!, doc.id);
    //15 parsed vehicle model

    return vehicle;
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

  Future<void> handleEntryScan({
    required String vehicleDocId,
    required String updatedBy,
  }) async {
    // 9 handleEntryScan called with DocID:
    // - 1. Fetch vehicle
    final vehicle = await getVehicleById(vehicleDocId);
    if (vehicle == null) {
      throw Exception("Vehicle not found");
    }

    // 16 vehicle status outside
    // - 2. Validate status
    if (vehicle.status == 'inside') {
      throw Exception("Vehicle already inside");
    }

    // - 3. Start session
    //17 starting vehicle session

    await startSession(vehicle, updatedBy);
    // 18 vehicle session started successfully
  }

  /// Handles an exit scan using vehicleDocId from QR
  Future<void> handleExitScan({
    required String vehicleDocId,
    required String updatedBy,
  }) async {
    // - 1. Fetch vehicle
    final vehicle = await getVehicleById(vehicleDocId);
    if (vehicle == null) {
      throw Exception("Vehicle not found");
    }

    // - 2. Validate status

    if (vehicle.status != 'inside') {
      throw Exception("Vehicle is not inside");
    }

    // - 3. End session

    await endSession(vehicle, updatedBy);
  }
}
