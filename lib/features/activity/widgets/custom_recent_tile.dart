import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomRecentTile extends StatelessWidget {
  const CustomRecentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColors.grey300),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Entry Scan',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSizes.bodySmall,
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                ' - Aug. 23, 2025 - 10:15 AM',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSizes.bodySmall,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'T342354',
                style: TextStyle(
                  fontFamily: 'Sora',
                  color: AppColors.grey300,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSizes.bodySmall,
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                '- Honda Wave ',
                style: TextStyle(
                  color: AppColors.grey300,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSizes.bodySmall,
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                '| Color: Orange',
                style: TextStyle(
                  color: AppColors.grey300,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSizes.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
