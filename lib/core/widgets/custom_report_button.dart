import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomReportButton extends StatelessWidget {
  final VoidCallback onTap;
  final String btnText;
  final bool isCancel;
  final Color bgColor;

  const CustomReportButton({
    super.key,
    required this.onTap,
    required this.btnText,
    required this.isCancel,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isCancel ? Colors.transparent : bgColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(
            width: 1.5,
            color: isCancel ? AppColors.grey400 : bgColor,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          btnText,
          style: TextStyle(
            color: isCancel ? AppColors.grey400 : AppColors.white,
            fontSize: AppFontSizes.bodyMedium,
          ),
        ),
      ),
    );
  }
}
