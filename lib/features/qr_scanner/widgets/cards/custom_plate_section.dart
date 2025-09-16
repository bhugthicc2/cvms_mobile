import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomPlateSection extends StatelessWidget {
  final String plateNumber;
  const CustomPlateSection({super.key, required this.plateNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 9,
            spreadRadius: 3,
            color: AppColors.shadow.withValues(alpha: 0.25),
          ),
        ],
      ),
      child: Padding(
        padding: AppSpacing.paddingAllLg,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(PhosphorIconsBold.info, color: AppColors.primary),
            AppSpacing.hXs,
            Text(
              plateNumber,
              style: TextStyle(
                color: AppColors.primary,
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
                fontSize: AppFontSizes.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
