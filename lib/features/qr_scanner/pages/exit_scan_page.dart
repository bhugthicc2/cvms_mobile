import 'package:cvms_mobile/features/qr_scanner/widgets/scanner_page/qr_scanner_page.dart';
import 'package:flutter/material.dart';

class ExitScanPage extends StatelessWidget {
  const ExitScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QrScannerPage(
      pageTitle: 'Scan Exit QR',
      instructionText:
          "Position the QR Code within the frame \n to scan for exit",
      onScan: (qrValue) {
        debugPrint("✅ Entrance QR: $qrValue");
        // TODO: handle entrance logic (API call, navigate, etc.)
      },
    );
  }
}
