import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/scanner_page/qr_scanner_page.dart';
import 'package:flutter/material.dart';

class EntranceScanPage extends StatelessWidget {
  const EntranceScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QrScannerPage(
      isExit: false,
      pageTitle: 'Scan Entry QR',
      instructionText:
          "Position the QR Code within the frame \n to scan for entry",
      onScan: (qrValue) {
        // todo handle entrance logic
        debugPrint("Entrance QR: $qrValue");
        // ex. Show snackbar at the screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            content: Text(
              'QR Data: $qrValue',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(top: 2, left: 16, right: 16),
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}
