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
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Sora',
        fontWeight: FontWeight.w600,
        fontSize: AppFontSizes.headlineSmall,
        color: AppColors.black,
      ),
    );
  }
}
