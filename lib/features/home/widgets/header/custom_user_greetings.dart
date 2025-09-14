import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomUserGreetings extends StatelessWidget {
  final String greeting;
  const CustomUserGreetings({super.key, required this.greeting});

  @override
  Widget build(BuildContext context) {
    return Text(
      greeting,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: AppColors.white),
    );
  }
}
