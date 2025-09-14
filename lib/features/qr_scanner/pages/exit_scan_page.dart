import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/scanner_page/qr_scanner_page.dart';
import 'package:flutter/material.dart';

class ExitScanPage extends StatelessWidget {
  const ExitScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QrScannerPage(
      isExit: true,
      pageTitle: 'Scan Exit QR',
      instructionText:
          "Position the QR Code within the frame \n to scan for exit",
      onScan: (qrValue) {
        // todo handle exit logic
        // ex. Show a toast
        BannerToast.show(
          context,
          message: 'QR Exit Data: $qrValue',
          type: BannerToastType.success,
        );
      },
    );
  }
}
