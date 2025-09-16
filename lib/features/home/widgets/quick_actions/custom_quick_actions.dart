import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class CustomQuickActions extends StatelessWidget {
  final VoidCallback onTap;
  final Gradient linearGradient;
  final String actionTitle;
  final String actionSubTitle;
  final IconData icon;

  const CustomQuickActions({
    super.key,
    required this.onTap,
    required this.linearGradient,
    required this.actionTitle,
    required this.icon,
    required this.actionSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: AppSpacing.paddingAllMd,
        decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: AppSpacing.paddingAllXs,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.white.withValues(alpha: 0.20),
              ),
              child: Icon(icon, color: AppColors.white, size: 25),
            ),
            AppSpacing.vSm,
            Text(
              actionTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sora',
              ),
            ),

            Text(
              actionSubTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.white.withValues(alpha: 0.5),
                fontWeight: FontWeight.w500,
                fontFamily: 'Sora',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
