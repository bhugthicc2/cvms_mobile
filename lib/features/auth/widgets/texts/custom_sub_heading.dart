import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomSubHeading extends StatelessWidget {
  final String subheading;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  const CustomSubHeading({
    super.key,
    required this.subheading,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subheading,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Sora',
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize ?? AppFontSizes.bodySmall,
        color: fontColor ?? AppColors.subheading,
      ),
    );
  }
}
