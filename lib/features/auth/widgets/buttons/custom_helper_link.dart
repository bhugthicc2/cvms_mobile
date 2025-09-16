import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomHelperLink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String btnText;
  const CustomHelperLink({
    super.key,
    required this.text,
    required this.onPressed,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: AppFontSizes.bodySmall,
            color: AppColors.grey400,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            textAlign: TextAlign.center,
            btnText,
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize: AppFontSizes.bodySmall,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
