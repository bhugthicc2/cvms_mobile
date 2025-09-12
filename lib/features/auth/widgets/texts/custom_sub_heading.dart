import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomSubHeading extends StatelessWidget {
  final String subheading;
  const CustomSubHeading({super.key, required this.subheading});

  @override
  Widget build(BuildContext context) {
    return Text(
      subheading,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Sora',
        fontWeight: FontWeight.w500,
        fontSize: AppFontSizes.bodySmall,
        color: AppColors.subheading,
      ),
    );
  }
}
