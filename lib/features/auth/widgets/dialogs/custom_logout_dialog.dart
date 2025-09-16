import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class CustomLogoutDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  const CustomLogoutDialog({
    super.key,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      insetPadding: AppSpacing.horizontalMd,
      title: const Text(
        'Confirm Logout',
        style: TextStyle(
          fontFamily: 'Sora',
          fontSize: AppFontSizes.titleMedium,
        ),
      ),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('No')),
        TextButton(
          onPressed: onSubmit,
          child: const Text('Yes', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
