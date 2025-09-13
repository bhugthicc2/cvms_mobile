import 'package:flutter/material.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';

class QrScannerFramePainter extends CustomPainter {
  final double cutoutFraction;
  final double cornerFraction;
  final double radiusFraction;
  final double strokeFraction;

  QrScannerFramePainter({
    this.cutoutFraction = 0.75,
    this.cornerFraction = 0.15,
    this.radiusFraction = 0.05,
    this.strokeFraction = 0.017,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //Calculate responsive sizes
    final cutoutSize = size.width * cutoutFraction;
    final cornerLength = cutoutSize * cornerFraction;
    final cornerRadius = cutoutSize * radiusFraction;
    final strokeWidth = cutoutSize * strokeFraction;

    //Overlay with cutout
    final overlayPaint =
        Paint()
          ..color = AppColors.primary.withValues(alpha: 0.38)
          ..style = PaintingStyle.fill;

    final outer = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final cutoutRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: cutoutSize,
      height: cutoutSize,
    );

    final cutout = RRect.fromRectXY(cutoutRect, cornerRadius, cornerRadius);

    final overlayPath = Path.combine(
      PathOperation.difference,
      outer,
      Path()..addRRect(cutout),
    );

    canvas.drawPath(overlayPath, overlayPaint);

    //Blue rounded corners
    final cornerPaint =
        Paint()
          ..color = AppColors.primary
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    // Top-left
    final topLeft =
        Path()
          ..moveTo(cutoutRect.left, cutoutRect.top + cornerLength)
          ..lineTo(cutoutRect.left, cutoutRect.top + cornerRadius)
          ..quadraticBezierTo(
            cutoutRect.left,
            cutoutRect.top,
            cutoutRect.left + cornerRadius,
            cutoutRect.top,
          )
          ..lineTo(cutoutRect.left + cornerLength, cutoutRect.top);
    canvas.drawPath(topLeft, cornerPaint);

    // Top-right
    final topRight =
        Path()
          ..moveTo(cutoutRect.right - cornerLength, cutoutRect.top)
          ..lineTo(cutoutRect.right - cornerRadius, cutoutRect.top)
          ..quadraticBezierTo(
            cutoutRect.right,
            cutoutRect.top,
            cutoutRect.right,
            cutoutRect.top + cornerRadius,
          )
          ..lineTo(cutoutRect.right, cutoutRect.top + cornerLength);
    canvas.drawPath(topRight, cornerPaint);

    // Bottom-left
    final bottomLeft =
        Path()
          ..moveTo(cutoutRect.left, cutoutRect.bottom - cornerLength)
          ..lineTo(cutoutRect.left, cutoutRect.bottom - cornerRadius)
          ..quadraticBezierTo(
            cutoutRect.left,
            cutoutRect.bottom,
            cutoutRect.left + cornerRadius,
            cutoutRect.bottom,
          )
          ..lineTo(cutoutRect.left + cornerLength, cutoutRect.bottom);
    canvas.drawPath(bottomLeft, cornerPaint);

    // Bottom-right
    final bottomRight =
        Path()
          ..moveTo(cutoutRect.right - cornerLength, cutoutRect.bottom)
          ..lineTo(cutoutRect.right - cornerRadius, cutoutRect.bottom)
          ..quadraticBezierTo(
            cutoutRect.right,
            cutoutRect.bottom,
            cutoutRect.right,
            cutoutRect.bottom - cornerRadius,
          )
          ..lineTo(cutoutRect.right, cutoutRect.bottom - cornerLength);
    canvas.drawPath(bottomRight, cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
