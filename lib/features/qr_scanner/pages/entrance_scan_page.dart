import 'package:cvms_mobile/features/qr_scanner/widgets/scanner_page/qr_scanner_page.dart';
import 'package:flutter/material.dart';

class EntranceScanPage extends StatelessWidget {
  const EntranceScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QrScannerPage(
      pageTitle: 'Scan Entry QR',
      instructionText:
          "Position the QR Code within the frame \n to scan for entry",
      onScan: (qrValue) {
        debugPrint("✅ Entrance QR: $qrValue");
        // TODO: handle entrance logic (API call, navigate, etc.)
      },
    );
  }
}
