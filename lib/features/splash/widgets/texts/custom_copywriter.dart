import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomCopywriter extends StatelessWidget {
  final String copywriter;
  const CustomCopywriter({super.key, required this.copywriter});

  @override
  Widget build(BuildContext context) {
    return Text(
      copywriter,
      style: TextStyle(
        fontFamily: 'Sora',
        color: AppColors.white.withValues(alpha: 0.6),
        fontSize: AppFontSizes.labelSmall,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
