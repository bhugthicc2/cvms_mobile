import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/services.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/features/qr_scanner/utils/sound_helper.dart';
import 'qr_scanner_state.dart';

class QrScannerCubit extends Cubit<QrScannerState> {
  final MobileScannerController controller = MobileScannerController();

  QrScannerCubit() : super(const QrScannerState());

  // Called automatically when the camera detects a QR code;
  // extracts its value and passes it to onScanAsync for processing.
  void onDetect(
    BarcodeCapture capture,
    Future<bool> Function(String) onScanAsync, // now expects true or false
  ) async {
    //if processing and barcodes are empty ignore
    if (state.isProcessing || capture.barcodes.isEmpty) return;
    // 1 stores the qr value
    //takes the first barcode that was captured from the list of barcodes
    final qrValue = capture.barcodes.first.rawValue ?? "Unknown QR";
    // Haptic feedback for vibration
    HapticFeedback.mediumImpact();
    //mark scanning as “in progress” | remember which QR was scanned|
    emit(state.copyWith(isProcessing: true, lastScannedValue: qrValue));

    bool success = false; //keep track of a success/failure state
    // ignore: unused_local_variable
    String? errorMessage; //keep track for the error message
    try {
      //2 Calling onScanAsync with qrValue
      success = await onScanAsync(
        qrValue,
      ); // runs an async QR-validation function and waits for its boolean result before moving on. | must return true/false
      // 26 onscan async returned true | success == true
    } catch (e) {
      success = false;
      //set success into false
      errorMessage = e.toString();
      //store the error message
    }

    final Color color; //stores the color
    if (qrValue.isEmpty || qrValue == "Unknown QR") {
      color = AppColors.error; //color when no qr is detected
    } else if (success) {
      color = AppColors.success; //color when the async validation is true
      // 27 success detected
    } else {
      color =
          AppColors.error; //color fallback if those options above are not true
    }
    // 28 about to play sound success
    if (success) {
      // 29 playing success sound
      //play success sound if async validation is true
      SoundHelper.playSuccess();
    } else {
      //play error sound if async validation is false
      SoundHelper.playError();
    }

    emit(
      state.copyWith(frameColor: color),
    ); //changes the frame color based on the async validation result

    // Wait 2 seconds to show success/error feedback,
    //then reset the scanner state back to normal (default color, ready for next scan).
    Future.delayed(const Duration(seconds: 2), () {
      if (isClosed) return; // don’t update if cubit/page is already closed
      emit(state.copyWith(isProcessing: false, frameColor: AppColors.primary));
    });
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
