import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomSubHeading extends StatelessWidget {
  final String subheading;
  final double? subheadingFontSize;
  const CustomSubHeading({
    super.key,
    required this.subheading,
    this.subheadingFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subheading,
      style: TextStyle(
        fontFamily: 'Sora',
        color: AppColors.white,
        fontSize: subheadingFontSize ?? AppFontSizes.labelSmall,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
