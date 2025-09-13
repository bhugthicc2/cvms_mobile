import 'package:cvms_mobile/features/qr_scanner/widgets/scanner_page/qr_scanner_page.dart';
import 'package:flutter/material.dart';

class VehicleScanPage extends StatelessWidget {
  const VehicleScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QrScannerPage(
      pageTitle: 'Scan Vehicle QR',
      instructionText:
          "Position the QR Code within the frame \n to scan for vehicle ID",
      onScan: (qrValue) {
        debugPrint("✅ Entrance QR: $qrValue");
        // TODO: handle entrance logic (API call, navigate, etc.)
      },
    );
  }
}
