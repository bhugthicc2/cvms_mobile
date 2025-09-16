import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  final String heading;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomHeading({
    super.key,
    required this.heading,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Sora',
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize ?? AppFontSizes.headlineSmall,
        color: AppColors.black,
      ),
    );
  }
}
