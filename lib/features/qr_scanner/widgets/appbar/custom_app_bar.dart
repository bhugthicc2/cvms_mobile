import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final VoidCallback toggleTorch;

  final VoidCallback switchCam;
  const CustomAppBar({
    super.key,
    required this.pageTitle,
    required this.toggleTorch,
    required this.switchCam,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(PhosphorIconsBold.caretLeft),
      ),
      title: Text(
        pageTitle,
        style: TextStyle(
          fontFamily: 'Sora',
          fontWeight: FontWeight.w600,
          fontSize: AppFontSizes.bodyMedium,
        ),
      ),

      actions: [
        IconButton(
          onPressed: toggleTorch,
          icon: Icon(PhosphorIconsBold.camera),
        ),
        IconButton(
          onPressed: switchCam,
          icon: Icon(PhosphorIconsBold.lightning),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
