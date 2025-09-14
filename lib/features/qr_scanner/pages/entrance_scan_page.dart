import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
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
        // ex. Show a toast
        BannerToast.show(
          context,
          message: 'QR Entrance Data: $qrValue',
          type: BannerToastType.success,
        );
      },
    );
  }
}
