import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/appbar/custom_app_bar.dart';
import 'package:cvms_mobile/features/qr_scanner/widgets/frame/qr_scanner_frame.dart';

class QrScannerPage extends StatefulWidget {
  final String pageTitle;
  final String instructionText;
  final ValueChanged<String> onScan; // callback when QR is scanned

  const QrScannerPage({
    super.key,
    required this.instructionText,
    required this.onScan,
    required this.pageTitle,
  });

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;

  void _onDetect(BarcodeCapture capture) {
    if (_isProcessing) return;

    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      setState(() => _isProcessing = true);

      final qrValue = barcodes.first.rawValue ?? "Unknown QR";
      widget.onScan(qrValue);

      // reset after short delay to allow next scan
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _isProcessing = false);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(pageTitle: widget.pageTitle),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
              fit: BoxFit.cover,
            ),
          ),

          // Frame overlay
          CustomPaint(size: screenSize, painter: QrScannerFramePainter()),

          // Instruction text
          Positioned(
            bottom: screenSize.height * 0.06,
            left: 24,
            right: 24,
            child: Text(
              widget.instructionText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white.withValues(alpha: 0.5),
                fontSize: AppFontSizes.bodySmall,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sora',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
