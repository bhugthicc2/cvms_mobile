import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String data;
  const CustomSnackbar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      showCloseIcon: true,
      content: Text(
        data,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: AppColors.success,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(top: 2, left: 16, right: 16),
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
