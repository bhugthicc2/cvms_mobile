import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  const CustomListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.black, size: 22),
      trailing: Icon(
        PhosphorIconsBold.caretRight,
        color: color ?? AppColors.grey400,
        size: 22,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: AppFontSizes.bodySmall,
          fontWeight: FontWeight.w500,
          fontFamily: 'Sora',
          color: color ?? AppColors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}
