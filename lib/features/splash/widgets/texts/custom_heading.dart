import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  final String heading;
  const CustomHeading({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(
        fontFamily: 'Sora',
        color: AppColors.primaryYellow,
        fontSize: AppFontSizes.headlineMedium,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
