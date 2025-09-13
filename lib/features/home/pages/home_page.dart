import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/features/home/models/chart_model.dart';
import 'package:cvms_mobile/features/home/widgets/drawer/custom_sidebar.dart';
import 'package:cvms_mobile/features/home/widgets/header/custom_app_bar.dart';
import 'package:cvms_mobile/features/home/widgets/charts/custom_donut_chart.dart';
import 'package:cvms_mobile/core/widgets/custom_header.dart';
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
    final headerHeight = size.height * 0.33;
    final statOffsetY = headerHeight * 0.20;
    final qaLabelOffsetY = headerHeight * 0.12;
    final gridOffsetY = headerHeight * 0.03;
    final chartData = [
      ChartModel('Entered', 45, const Color(0xFFFACC15)),
      ChartModel('Exited', 75, const Color(0xFF3B82F6)),
      ChartModel('Others', 180, const Color(0xFF14B8A6)),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: headerHeight,
            child: CustomHeader(
              headerHeight: headerHeight,
              backgroundColor: AppColors.primary,
              padding: AppSpacing.homePadding,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(
                      builder:
                          (context) => CustomAppBar(
                            toggleSidebar: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                    ),
                    AppSpacing.vLg,
                    const CustomUserGreetings(greeting: 'Good Morning,'),
                    AppSpacing.vXxs,
                    const CustomUserText(userName: 'Jesie Gapol'),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: AppSpacing.horizontalLg,
              child: Transform.translate(
                offset: Offset(0, -statOffsetY),
                child: CustomStatCard(
                  statCardHeight: double.infinity,
                  child: CustomDonutChart(data: chartData),
                ),
              ),
            ),
          ),

          Padding(
            padding: AppSpacing.horizontalLg,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Transform.translate(
                offset: Offset(0, -qaLabelOffsetY),
                child: const CustomQaLabel(label: 'Quick Actions'),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: AppSpacing.horizontalLg,
              child: Transform.translate(
                offset: Offset(0, -gridOffsetY),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.lg,
                  mainAxisSpacing: AppSpacing.lg,
                  padding: EdgeInsets.zero,
                  children: [
                    CustomQuickActions(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.entryScan);
                      },
                      linearGradient: AppColors.greenWhite,
                      actionTitle: 'Entrance Scan',
                      actionSubTitle: 'Scan entrance QR',
                      icon: PhosphorIconsBold.gridFour,
                    ),
                    CustomQuickActions(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.exitScan);
                      },
                      linearGradient: AppColors.yellowWhite,
                      actionTitle: 'Exit Scan',
                      actionSubTitle: 'Scan exit QR',
                      icon: PhosphorIconsBold.signOut,
                    ),
                    CustomQuickActions(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.vehicleScan);
                      },
                      linearGradient: AppColors.blueWhite,
                      actionTitle: 'Vehicle Scan',
                      actionSubTitle: 'Scan vehicles QR',
                      icon: PhosphorIconsBold.motorcycle,
                    ),
                    CustomQuickActions(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.recentActivity);
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
          ),
        ],
      ),
    );
  }
}
