import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/widgets/custom_header.dart';
import 'package:cvms_mobile/features/activity/widgets/custom_recent_tile.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class RecentActivityPage extends StatelessWidget {
  const RecentActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final headerHeight = size.height * 0.29;

    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: CustomAppBar(pageTitle: 'Recent Activity'),
      body: Stack(
        children: [
          SizedBox(
            height: headerHeight,
            width: double.infinity,
            child: CustomHeader(
              headerHeight: headerHeight,
              backgroundColor: AppColors.primary,
              padding: AppSpacing.homePadding,
            ),
          ),
          Positioned(
            child: Expanded(
              child: SizedBox(
                child: Padding(
                  padding: AppSpacing.horizontalLg,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vSm,
                        CustomRecentTile(),
                        AppSpacing.vLg,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
