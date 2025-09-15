import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:cvms_mobile/core/utils/time_greeting_helper.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_state.dart';
import 'package:cvms_mobile/features/home/bloc/vehicle_stats_cubit.dart';
import 'package:cvms_mobile/features/home/bloc/vehicle_stats_state.dart';
import 'package:cvms_mobile/features/home/data/vehicle_logs_repository.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final greeting = TimeGreetingHelper.greeting();
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.30 - kToolbarHeight;
    final statOffsetY = headerHeight * 0.31;
    final qaLabelOffsetY = headerHeight * 0.19;
    final gridOffsetY = headerHeight * 0.09;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final currentUser =
            context.read<AuthCubit>().state is AuthAuthenticated
                ? (context.read<AuthCubit>().state as AuthAuthenticated).user
                : null;

        return BlocProvider(
          create:
              (_) =>
                  VehicleStatsCubit(VehicleLogsRepository())
                    ..watchVehicleStats(),
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(
              toggleSidebar: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
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
                          AppSpacing.vMd,
                          CustomUserGreetings(greeting: '$greeting, '),
                          AppSpacing.vXxs,
                          CustomUserText(
                            userName:
                                currentUser?.fullname ??
                                AppStrings.securityPersonnel,
                          ),
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
                        child:
                            BlocBuilder<VehicleStatsCubit, VehicleStatsState>(
                              builder: (context, state) {
                                if (state is VehicleStatsLoading) {
                                  return const Center(
                                    //todo add a better progress indicator
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is VehicleStatsLoaded) {
                                  final chartData = state.chartData;
                                  return CustomDonutChart(data: chartData);
                                } else if (state is VehicleStatsError) {
                                  return Center(
                                    child: Text('Error: ${state.message}'),
                                  );
                                } else {
                                  // todo add empty state
                                  return const SizedBox();
                                }
                              },
                            ),
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
                      child: const CustomQaLabel(label: AppStrings.qaLabel),
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
                            actionTitle: AppStrings.entranceScanTitle,
                            actionSubTitle: AppStrings.entranceScanSubtitle,
                            icon: PhosphorIconsBold.gridFour,
                          ),
                          CustomQuickActions(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.exitScan);
                            },
                            linearGradient: AppColors.yellowWhite,
                            actionTitle: AppStrings.exitScanTitle,
                            actionSubTitle: AppStrings.exitScanSubtitle,
                            icon: PhosphorIconsBold.signOut,
                          ),
                          CustomQuickActions(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                // AppRoutes.vehicleScan,
                                AppRoutes.vehicleInfo,
                              );
                            },
                            linearGradient: AppColors.blueWhite,
                            actionTitle: AppStrings.vehicleScanTitle,
                            actionSubTitle: AppStrings.vehicleScanSubtitle,
                            icon: PhosphorIconsBold.motorcycle,
                          ),
                          CustomQuickActions(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.recentActivity,
                              );
                            },
                            linearGradient: AppColors.pinkWhite,
                            actionTitle: AppStrings.recentActivityTitle,
                            actionSubTitle: AppStrings.recentActivitySubtitle,
                            icon: PhosphorIconsBold.arrowCounterClockwise,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
