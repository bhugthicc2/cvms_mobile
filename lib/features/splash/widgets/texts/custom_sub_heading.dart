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
      style: TextStyle(
        fontFamily: 'Sora',
        color: AppColors.white,
        fontSize: AppFontSizes.labelSmall,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
