import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool readOnly;
  final String? initialValue;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.readOnly = false,
    this.initialValue,
    this.onChanged,
    this.keyboardType,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 4,
            color: Color(0xFFBCBCBC).withValues(alpha: 0.25),
          ),
        ],
        color: AppColors.white,
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          enabled: enabled,
          keyboardType: keyboardType,
          onChanged: onChanged,
          initialValue: controller == null ? initialValue : null,
          style: TextStyle(
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
            fontSize: AppFontSizes.labelLarge,
          ),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontFamily: 'Sora',
              fontWeight: FontWeight.w600,
              fontSize: AppFontSizes.labelLarge,
            ),
            floatingLabelStyle: TextStyle(
              fontFamily: 'Sora',
              fontWeight: FontWeight.w600,
              color: AppColors.grey400,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }
}
