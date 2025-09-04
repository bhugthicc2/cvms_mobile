import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/statistics_model.dart';

class StatisticsCard extends StatelessWidget {
  final StatisticsModel statistics;

  const StatisticsCard({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Legend
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                      'Entered',
                      statistics.entered,
                      statistics.enteredPercentage,
                      const Color(0xFFF1C40F), // Yellow
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      'Exited',
                      statistics.exited,
                      statistics.exitedPercentage,
                      const Color(0xFF3498DB), // Blue
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      'Others',
                      statistics.others,
                      statistics.othersPercentage,
                      const Color(0xFF2ECC71), // Teal/Green
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Donut Chart
              Expanded(flex: 2, child: _buildDonutChart()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    String label,
    int count,
    double percentage,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.sora(
                  fontSize: 14,
                  color: const Color(0xFF2C3E50),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$count ${percentage.toStringAsFixed(0)}%',
                style: GoogleFonts.sora(
                  fontSize: 16,
                  color: const Color(0xFF2C3E50),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDonutChart() {
    return CustomPaint(
      size: const Size(120, 120),
      painter: DonutChartPainter(
        enteredPercentage: statistics.enteredPercentage,
        exitedPercentage: statistics.exitedPercentage,
        othersPercentage: statistics.othersPercentage,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total',
              style: GoogleFonts.sora(
                fontSize: 12,
                color: const Color(0xFF7F8C8D),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${statistics.total}',
              style: GoogleFonts.sora(
                fontSize: 20,
                color: const Color(0xFF2C3E50),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final double enteredPercentage;
  final double exitedPercentage;
  final double othersPercentage;

  DonutChartPainter({
    required this.enteredPercentage,
    required this.exitedPercentage,
    required this.othersPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final strokeWidth = 20.0;

    double startAngle = -90 * (3.14159 / 180); // Start from top

    // Entered (Yellow)
    final enteredPaint =
        Paint()
          ..color = const Color(0xFFF1C40F)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    final enteredSweepAngle = (enteredPercentage / 100) * 2 * 3.14159;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      enteredSweepAngle,
      false,
      enteredPaint,
    );

    startAngle += enteredSweepAngle;

    // Exited (Blue)
    final exitedPaint =
        Paint()
          ..color = const Color(0xFF3498DB)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    final exitedSweepAngle = (exitedPercentage / 100) * 2 * 3.14159;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      exitedSweepAngle,
      false,
      exitedPaint,
    );

    startAngle += exitedSweepAngle;

    // Others (Teal/Green)
    final othersPaint =
        Paint()
          ..color = const Color(0xFF2ECC71)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    final othersSweepAngle = (othersPercentage / 100) * 2 * 3.14159;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      othersSweepAngle,
      false,
      othersPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
