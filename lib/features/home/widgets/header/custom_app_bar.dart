import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            //todo
            debugPrint('Menu CLicked');
          },
          child: Icon(PhosphorIconsBold.list, color: AppColors.white),
        ),
        Spacer(),
        Text(
          'Home',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sora',
            fontSize: AppFontSizes.bodyMedium,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            //todo
            debugPrint('Profile CLicked');
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 3, color: AppColors.white),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: AppColors.primary),
              ),
              child: CircleAvatar(
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
