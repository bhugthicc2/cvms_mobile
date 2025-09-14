import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../models/chart_model.dart';
import 'package:flutter/material.dart';

class VehicleLogsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ChartModel>> watchVehicleStatsForToday() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // Combine three streams into one list of ChartModel
    final insideStream =
        _db
            .collection('vehicle_logs')
            .where('status', isEqualTo: 'inside')
            .where('timeIn', isGreaterThanOrEqualTo: startOfDay)
            .where('timeIn', isLessThan: endOfDay)
            .snapshots();

    final outsideStream =
        _db
            .collection('vehicle_logs')
            .where('status', isEqualTo: 'outside')
            .where('timeOut', isGreaterThanOrEqualTo: startOfDay)
            .where('timeOut', isLessThan: endOfDay)
            .snapshots();

    final othersStream =
        _db
            .collection('violations')
            .where('createdAt', isGreaterThanOrEqualTo: startOfDay)
            .where('createdAt', isLessThan: endOfDay)
            .snapshots();

    // Combine 3 snapshot streams into one ChartModel list
    return Rx.combineLatest3<
      QuerySnapshot,
      QuerySnapshot,
      QuerySnapshot,
      List<ChartModel>
    >(insideStream, outsideStream, othersStream, (
      insideSnap,
      outsideSnap,
      othersSnap,
    ) {
      return [
        ChartModel(
          'Entered',
          insideSnap.docs.length.toDouble(),
          const Color(0xFFFACC15),
        ),
        ChartModel(
          'Exited',
          outsideSnap.docs.length.toDouble(),
          const Color(0xFF3B82F6),
        ),
        ChartModel(
          'Violations',
          othersSnap.docs.length.toDouble(),
          const Color(0xFF14B8A6),
        ),
      ];
    });
  }
}
