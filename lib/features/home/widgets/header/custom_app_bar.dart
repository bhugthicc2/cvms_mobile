import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback toggleSidebar;
  const CustomAppBar({super.key, required this.toggleSidebar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: Padding(
        padding: EdgeInsets.only(left: AppSpacing.md),
        child: GestureDetector(
          onTap: toggleSidebar,
          child: Icon(PhosphorIconsBold.list, color: AppColors.white),
        ),
      ),
      title: Text(
        'Home',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Sora',
          fontSize: AppFontSizes.bodyMedium,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: AppSpacing.lg),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2.5, color: AppColors.white),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: AppColors.primary),
                ),
                child: CircleAvatar(
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
