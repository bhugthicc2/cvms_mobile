import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
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
      onScan: (qrValue) async {
        // todo implement a logic to view the vehicle info after a successful qr scan
        BannerToast.show(
          context,
          message: 'QR Info Data: $qrValue',
          type: BannerToastType.success,
        );
        // Temporary return - replace with actual logic
        return true;
      },
    );
  }
}
