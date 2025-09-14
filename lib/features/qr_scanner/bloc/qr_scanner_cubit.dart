import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/services.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/features/qr_scanner/utils/sound_helper.dart';
import 'qr_scanner_state.dart';

class QrScannerCubit extends Cubit<QrScannerState> {
  final MobileScannerController controller = MobileScannerController();

  QrScannerCubit() : super(const QrScannerState());

  void onDetect(BarcodeCapture capture, void Function(String) onScan) async {
    if (state.isProcessing || capture.barcodes.isEmpty) return;

    final qrValue = capture.barcodes.first.rawValue ?? "Unknown QR";

    // Haptic feedback
    HapticFeedback.mediumImpact();

    onScan(qrValue);

    // Determine color based on QR validity and data matching
    var color = _determineFrameColor(qrValue);

    // Play sound based on result
    if (color == AppColors.success) {
      SoundHelper.playSuccess();
    } else if (color == AppColors.error) {
      SoundHelper.playError();
    } else {
      SoundHelper.playWarning();
    }

    emit(
      state.copyWith(
        isProcessing: true,
        lastScannedValue: qrValue,
        frameColor: color,
      ),
    );

    // Reset after delay
    Future.delayed(const Duration(seconds: 2), () {
      if (isClosed) return;
      emit(state.copyWith(isProcessing: false, frameColor: AppColors.primary));
    });
  }

  Color _determineFrameColor(String qrValue) {
    // Check if QR is valid format (not empty, not "Unknown QR")
    if (qrValue.isEmpty || qrValue == "Unknown QR") {
      return AppColors.error; // Red for invalid QR
    }

    // Check if data matches expected format (you can customize this logic)
    if (_isValidData(qrValue)) {
      return AppColors.success; // Green for valid and matched data
    } else {
      return AppColors.warning; // Orange/Yellow for valid QR but unmatched data
    }
  }

  bool _isValidData(String qrValue) {
    // todo implement logic soon
    // 1. Scan QR code → extract vehicleDocId
    // 2. Check Firestore → does this ID exist in the vehicles collection?
    // 3. Check status → is it "outside"?
    // 4. If valid →
    // 5. Create a new log in vehicle_logs
    // 6. Update the vehicle status to "inside"
    // 7. Else → show error (like "Already inside" or "Invalid vehicle").
    // 8. For now, simple example - you can replace with your logic
    return qrValue.length >= 3;
  }

  void toggleTorch() {
    controller.toggleTorch();
    emit(state.copyWith(torchEnabled: !state.torchEnabled));
  }

  void switchCamera() {
    controller.switchCamera();
    emit(state.copyWith(usingFrontCamera: !state.usingFrontCamera));
  }

  void reset() {
    emit(const QrScannerState());
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
