import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/features/home/widgets/drawer/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomInfoSection extends StatelessWidget {
  final String categoryName;
  const CustomInfoSection({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 9,
            spreadRadius: 3,
            color: AppColors.shadow.withValues(alpha: 0.25),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: AppSpacing.paddingAllMd,
            child: Row(
              children: [
                Icon(PhosphorIconsBold.user, color: AppColors.primary),
                AppSpacing.hXs,
                Text(
                  categoryName,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSizes.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          CustomDivider(),
          Padding(
            padding: AppSpacing.paddingAllLg,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sample'),
                      Text('Sample'),
                      Text('Sample'),
                      Text('Sample'),
                      Text('Sample'),
                      Text('Sample'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sample',
                        style: TextStyle(
                          color: AppColors.grey300,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w500,
                          fontSize: AppFontSizes.bodyMedium,
                        ),
                      ),
                      Text(
                        'Sample',
                        style: TextStyle(
                          color: AppColors.grey300,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w500,
                          fontSize: AppFontSizes.bodyMedium,
                        ),
                      ),
                      Text(
                        'Sample',
                        style: TextStyle(
                          color: AppColors.grey300,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w500,
                          fontSize: AppFontSizes.bodyMedium,
                        ),
                      ),
                      Text(
                        'Sample',
                        style: TextStyle(
                          color: AppColors.grey300,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w500,
                          fontSize: AppFontSizes.bodyMedium,
                        ),
                      ),
                      Text(
                        'Sample',
                        style: TextStyle(
                          color: AppColors.grey300,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w500,
                          fontSize: AppFontSizes.bodyMedium,
                        ),
                      ),
                      Text(
                        'Sample',
                        style: TextStyle(
                          color: AppColors.grey300,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w500,
                          fontSize: AppFontSizes.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
