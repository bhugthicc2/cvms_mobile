import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/widgets/custom_header.dart';
import 'package:cvms_mobile/features/vehicle_info/widgets/custom_vehicle_section.dart';
import 'package:cvms_mobile/features/vehicle_info/widgets/custom_plate_section.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/widgets/custom_app_bar.dart';

class VehicleInfoPage extends StatelessWidget {
  const VehicleInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.28;
    final recentItemsCount = 10;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        pageTitle: 'Vehicle Information',
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(PhosphorIconsBold.warning, color: AppColors.white),
          ),
        ],
      ),
      body: Stack(
        children: [
          CustomHeader(headerHeight: headerHeight),
          ListView(
            padding: EdgeInsets.only(
              top: AppSpacing.md,
              left: AppSpacing.horizontalLg.left,
              right: AppSpacing.horizontalLg.right,
              bottom: AppSpacing.lg,
            ),
            children: [
              const CustomPlateSection(plateNumber: 'Plate Number Sample'),
              AppSpacing.vLg,
              ...List.generate(
                recentItemsCount,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.lg),
                  child: const CustomInfoSection(categoryName: 'Student Info'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
