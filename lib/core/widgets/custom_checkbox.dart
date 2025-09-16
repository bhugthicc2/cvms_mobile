import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final double size;

  const CustomCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.size = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
        checkColor: AppColors.white,
        side: const BorderSide(color: AppColors.grey400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}
