import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomUserText extends StatelessWidget {
  final String userName;
  const CustomUserText({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
