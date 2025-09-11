import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanVehiclePage extends StatefulWidget {
  const ScanVehiclePage({super.key});

  @override
  State<ScanVehiclePage> createState() => _ScanVehiclePageState();
}

class _ScanVehiclePageState extends State<ScanVehiclePage> {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionTimeoutMs: 800,
    formats: const [BarcodeFormat.qrCode],
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _isHandling = false;
  bool _torchOn = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isHandling) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null) return;
    setState(() => _isHandling = true);
    final value = barcode.rawValue ?? '';
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('QR detected: $value')));
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isHandling = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Scan Vehicle QR',
          style: GoogleFonts.sora(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch_outlined, color: Colors.white),
            onPressed: () async {
              try {
                await _scannerController.switchCamera();
              } catch (_) {}
            },
          ),
          IconButton(
            icon: Icon(
              _torchOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
            ),
            onPressed: () async {
              try {
                await _scannerController.toggleTorch();
                if (mounted) setState(() => _torchOn = !_torchOn);
              } catch (_) {}
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: _scannerController,
              onDetect: _onDetect,
            ),
          ),
          Positioned.fill(child: _ScannerOverlay()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                'Position the  QR Code within the frame\n to scan vehicle',
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF9EB6F6),
    );
  }
}

class _ScannerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = constraints.maxWidth * 0.7;
        return Stack(
          children: [
            ClipPath(
              clipper: _CutoutClipper(size: size, radius: 16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  color: const Color(0xFF9EB6F6).withOpacity(0.85),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: size,
                height: size,
                child: CustomPaint(
                  painter: _CornerPainter(
                    color: const Color(0xFF2F80ED),
                    stroke: 6,
                    radius: 16,
                    len: 32,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CutoutClipper extends CustomClipper<Path> {
  _CutoutClipper({required this.size, required this.radius});
  final double size;
  final double radius;

  @override
  Path getClip(Size s) {
    final Path outer = Path()..addRect(Offset.zero & s);
    final Rect r = Rect.fromCenter(
      center: Offset(s.width / 2, s.height / 2 - 20),
      width: size,
      height: size,
    );
    final Path hole =
        Path()..addRRect(RRect.fromRectAndRadius(r, Radius.circular(radius)));
    return Path.combine(PathOperation.difference, outer, hole);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _CornerPainter extends CustomPainter {
  _CornerPainter({
    required this.color,
    required this.stroke,
    required this.radius,
    required this.len,
  });
  final Color color;
  final double stroke;
  final double radius;
  final double len;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p =
        Paint()
          ..color = color
          ..strokeWidth = stroke
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final Rect r = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    ).shift(Offset(0, -20));
    canvas.drawLine(
      r.topLeft + Offset(0, radius),
      r.topLeft + Offset(0, len),
      p,
    );
    canvas.drawLine(
      r.topLeft + Offset(radius, 0),
      r.topLeft + Offset(len, 0),
      p,
    );
    canvas.drawLine(
      r.topRight + Offset(0, radius),
      r.topRight + Offset(0, len),
      p,
    );
    canvas.drawLine(
      r.topRight + Offset(-radius, 0),
      r.topRight + Offset(-len, 0),
      p,
    );
    canvas.drawLine(
      r.bottomLeft + Offset(0, -radius),
      r.bottomLeft + Offset(0, -len),
      p,
    );
    canvas.drawLine(
      r.bottomLeft + Offset(radius, 0),
      r.bottomLeft + Offset(len, 0),
      p,
    );
    canvas.drawLine(
      r.bottomRight + Offset(0, -radius),
      r.bottomRight + Offset(0, -len),
      p,
    );
    canvas.drawLine(
      r.bottomRight + Offset(-radius, 0),
      r.bottomRight + Offset(-len, 0),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
