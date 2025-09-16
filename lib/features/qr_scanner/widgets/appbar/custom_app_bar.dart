import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final VoidCallback toggleTorch;
  final VoidCallback switchCam;
  final bool isTorchOn;
  final bool isFrontCamera;

  const CustomAppBar({
    super.key,
    required this.pageTitle,
    required this.toggleTorch,
    required this.switchCam,
    this.isTorchOn = false,
    this.isFrontCamera = false,
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
        // Camera switch button
        IconButton(
          onPressed: switchCam,
          icon: Icon(
            isFrontCamera ? PhosphorIconsFill.camera : PhosphorIconsBold.camera,
          ),
          tooltip:
              isFrontCamera
                  ? 'Switch to back camera'
                  : 'Switch to front camera',
        ),
        // Torch toggle button
        IconButton(
          onPressed: toggleTorch,
          icon: Icon(
            isTorchOn
                ? PhosphorIconsFill.lightning
                : PhosphorIconsBold.lightning,
          ),
          tooltip: isTorchOn ? 'Turn off torch' : 'Turn on torch',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
