import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvms_mobile/features/qr_scanner/models/violation_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'violation_state.dart';

class ViolationCubit extends Cubit<ViolationState> {
  ViolationCubit() : super(ViolationInitial());

  Future<void> reportViolation({
    required String reportedBy,
    required String plateNumber,
    required String vehicleID,
    required String owner,
    required String violation,
  }) async {
    try {
      emit(ViolationLoading());
      final violationData = ViolationModel(
        violationID: '', // Firestore will generate ID
        dateTime: Timestamp.now(),
        reportedBy: reportedBy,
        plateNumber: plateNumber,
        vehicleID: vehicleID,
        owner: owner,
        violation: violation,
        status: 'pending',
      );

      await FirebaseFirestore.instance
          .collection('violations')
          .add(violationData.toMap());

      emit(ViolationSuccess());
    } catch (e) {
      emit(ViolationError('Failed to report violation: $e'));
    }
  }
}
