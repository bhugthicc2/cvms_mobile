import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomQaLabel extends StatelessWidget {
  final String label;
  const CustomQaLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Sora',
      ),
    );
  }
}
