import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EntranceScanPage extends StatelessWidget {
  const EntranceScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
    );
  }
}
