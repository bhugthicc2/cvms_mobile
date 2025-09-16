import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  final String heading;
  final double? headingFontSize;
  const CustomHeading({super.key, required this.heading, this.headingFontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(
        fontFamily: 'Sora',
        color: AppColors.primaryYellow,
        fontSize: headingFontSize ?? AppFontSizes.headlineMedium,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
