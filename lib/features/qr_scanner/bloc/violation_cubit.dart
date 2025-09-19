import 'package:cvms_mobile/features/qr_scanner/data/violation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'violation_state.dart';

class ViolationCubit extends Cubit<ViolationState> {
  final ViolationRepository _violationRepository;

  ViolationCubit({ViolationRepository? violationRepository})
    : _violationRepository = violationRepository ?? ViolationRepository(),
      super(ViolationInitial());

  Future<void> reportViolation({
    required String reportedBy,
    required String plateNumber,
    required String vehicleID,
    required String owner,
    required String violation,
  }) async {
    try {
      emit(ViolationLoading());

      await _violationRepository.reportViolation(
        reportedBy: reportedBy,
        plateNumber: plateNumber,
        vehicleID: vehicleID,
        owner: owner,
        violation: violation,
      );

      emit(ViolationSuccess());
    } catch (e) {
      emit(ViolationError('Failed to report violation: $e'));
    }
  }
}
