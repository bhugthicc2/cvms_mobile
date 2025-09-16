import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/features/home/widgets/drawer/custom_divider.dart';
import 'package:cvms_mobile/features/qr_scanner/models/info_section_data.dart';
import 'package:flutter/material.dart';

class CustomInfoSection extends StatelessWidget {
  final String categoryName;
  final IconData icon;
  final List<InfoSectionData> data;
  final double rowSpacing;

  const CustomInfoSection({
    super.key,
    required this.categoryName,
    required this.icon,
    required this.data,
    this.rowSpacing = 6.0,
  });

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
                Icon(icon, color: AppColors.primary),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      data.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: index == data.length - 1 ? 0 : rowSpacing,
                        ),
                        child: Text(
                          data[index].label,
                          style: TextStyle(
                            color: AppColors.black,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                            fontSize: AppFontSizes.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      data.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: index == data.length - 1 ? 0 : rowSpacing,
                        ),
                        child: Text(
                          data[index].value,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.grey400,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w500,
                            fontSize: AppFontSizes.bodySmall,
                          ),
                        ),
                      ),
                    ),
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
