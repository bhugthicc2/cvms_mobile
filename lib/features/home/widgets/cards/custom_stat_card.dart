import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class CustomStatCard extends StatelessWidget {
  final double statCardHeight;
  final Widget child;
  const CustomStatCard({
    super.key,
    required this.statCardHeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingAllMd,
      height: statCardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
