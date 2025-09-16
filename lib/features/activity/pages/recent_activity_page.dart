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
    final headerHeight = size.height * 0.28;
    final recentItemsCount = 10;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(pageTitle: 'Recent Activity'),
      body: Stack(
        children: [
          CustomHeader(headerHeight: headerHeight),
          ListView.separated(
            padding: EdgeInsets.only(
              top: AppSpacing.md,
              left: AppSpacing.horizontalLg.left,
              right: AppSpacing.horizontalLg.right,
              bottom: AppSpacing.lg,
            ),
            itemCount: recentItemsCount,
            separatorBuilder: (_, __) => AppSpacing.vSm,
            itemBuilder: (context, index) {
              return const CustomRecentTile();
            },
          ),
        ],
      ),
    );
  }
}
