import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomRecentTile extends StatelessWidget {
  final String action;
  final String timestamp;
  final String plateNumber;
  final String vehicleModel;
  final String vehicleColor;
  final String violation;

  const CustomRecentTile({
    super.key,
    required this.action,
    required this.timestamp,
    required this.plateNumber,
    required this.vehicleModel,
    required this.vehicleColor,
    required this.violation,
  });

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
                action,
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSizes.bodySmall,
                ),
              ),
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  ' - $timestamp',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w500,
                    fontSize: AppFontSizes.bodySmall,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "$plateNumber - $vehicleModel | ${action == 'Violation Report' ? 'Violation' : 'Color'}: ${action == 'Violation Report' ? violation : vehicleColor}",
                  style: TextStyle(
                    fontFamily: 'Sora',
                    color: AppColors.grey300,
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSizes.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
