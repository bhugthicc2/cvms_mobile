import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/features/home/models/chart_model.dart';
import 'package:cvms_mobile/features/home/widgets/header/custom_app_bar.dart';
import 'package:cvms_mobile/features/home/widgets/charts/custom_donut_chart.dart';
import 'package:cvms_mobile/features/home/widgets/header/custom_header.dart';
import 'package:cvms_mobile/features/home/widgets/quick_actions/custom_qa_label.dart';
import 'package:cvms_mobile/features/home/widgets/quick_actions/custom_quick_actions.dart';
import 'package:cvms_mobile/features/home/widgets/cards/custom_stat_card.dart';
import 'package:cvms_mobile/features/home/widgets/header/custom_user_greetings.dart';
import 'package:cvms_mobile/features/home/widgets/header/custom_user_text.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.35;
    final overlap = headerHeight * 0.25;
    final statCardHeight = 160.0;
    final quickActionsHeight = 340.0;

    final labelSpacing = AppSpacing.sm;
    final labelHeight = 20.0;

    final gridTopSpacing = AppSpacing.sm;
    final labelTopSpacing = AppSpacing.sm;

    final labelTop =
        (headerHeight - overlap) +
        statCardHeight +
        labelSpacing +
        labelTopSpacing;
    final gridTop = labelTop + labelHeight + labelSpacing + gridTopSpacing;

    final chartData = [
      ChartModel('Entered', 45, Color(0xFFFACC15)),
      ChartModel('Exited', 75, Color(0xFF3B82F6)),
      ChartModel('Others', 180, Color(0xFF14B8A6)),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // HEADER
          CustomHeader(
            headerHeight: headerHeight,
            backgroundColor: AppColors.primary,
            padding: AppSpacing.homePadding,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(),
                  AppSpacing.vLg,
                  CustomUserGreetings(greeting: 'Good Morning,'),
                  AppSpacing.vXxs,
                  CustomUserText(userName: 'Jesie Gapol'),
                ],
              ),
            ),
          ),

          // STAT CARD
          Positioned(
            top: headerHeight - overlap,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: CustomStatCard(
              statCardHeight: statCardHeight,
              child: CustomDonutChart(data: chartData),
            ),
          ),
          // QUICK ACTIONS LABEL
          Positioned(
            top: labelTop,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: IgnorePointer(child: CustomQaLabel(label: 'Quick Actions')),
          ),

          // QUICK ACTIONS GRID
          Positioned(
            top: gridTop,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: SizedBox(
              height: quickActionsHeight,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.lg,
                mainAxisSpacing: AppSpacing.lg,
                padding: EdgeInsets.zero,

                children: [
                  CustomQuickActions(
                    onTap: () {
                      //todo
                      debugPrint('Entry scan clicked!!!');
                      Navigator.pushNamed(context, AppRoutes.entryScan);
                    },
                    linearGradient: AppColors.greenWhite,
                    actionTitle: 'Entrance Scan',
                    actionSubTitle: 'Scan entrance QR',
                    icon: PhosphorIconsBold.gridFour,
                  ),
                  CustomQuickActions(
                    onTap: () {
                      debugPrint('Exit scan clicked!!!');
                      //todo
                    },
                    linearGradient: AppColors.yellowWhite,
                    actionTitle: 'Exit Scan',
                    actionSubTitle: 'Scan exit QR',
                    icon: PhosphorIconsBold.signOut,
                  ),
                  CustomQuickActions(
                    onTap: () {
                      debugPrint('vehicle scan clicked!!!');
                      //todo
                    },
                    linearGradient: AppColors.blueWhite,
                    actionTitle: 'Vehicle Scan',
                    actionSubTitle: 'Scan vehicles QR',
                    icon: PhosphorIconsBold.motorcycle,
                  ),
                  CustomQuickActions(
                    onTap: () {
                      debugPrint('Recent act clicked!!!');
                      //todo
                    },
                    linearGradient: AppColors.pinkWhite,
                    actionTitle: 'Recent Activity',
                    actionSubTitle: 'View activity history',
                    icon: PhosphorIconsBold.arrowCounterClockwise,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
