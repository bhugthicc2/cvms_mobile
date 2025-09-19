import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/utils/date_formatter.dart';
import 'package:cvms_mobile/core/widgets/custom_header.dart';
import 'package:cvms_mobile/features/activity/bloc/activity_cubit.dart';
import 'package:cvms_mobile/features/activity/widgets/custom_recent_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_app_bar.dart';

class RecentActivityPage extends StatefulWidget {
  const RecentActivityPage({super.key});

  @override
  State<RecentActivityPage> createState() => _RecentActivityPageState();
}

class _RecentActivityPageState extends State<RecentActivityPage> {
  @override
  void initState() {
    super.initState();
    context.read<ActivityCubit>().fetchRecentActivities(limit: 20);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.28;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(pageTitle: 'Recent Activity'),
      body: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          if (state is ActivityLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ActivityLoaded) {
            final activities = state.activities;
            return Stack(
              children: [
                CustomHeader(headerHeight: headerHeight),
                ListView.separated(
                  padding: EdgeInsets.only(
                    top: AppSpacing.md,
                    left: AppSpacing.horizontalLg.left,
                    right: AppSpacing.horizontalLg.right,
                    bottom: AppSpacing.lg,
                  ),
                  itemCount: activities.length,
                  separatorBuilder: (_, __) => AppSpacing.vSm,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    final isViolationReport =
                        activity.action == 'Violation Report';
                    return CustomRecentTile(
                      action: activity.action,
                      timestamp: DateFormatter.formatShort(activity.timestamp),
                      plateNumber:
                          activity.additionalData?['plateNumber'] ?? '',
                      vehicleModel:
                          activity.additionalData?['vehicleModel'] ?? '',
                      violation: activity.additionalData?['violation'] ?? '',
                      vehicleColor:
                          isViolationReport
                              ? (activity.additionalData?['violation'] ?? '')
                              : (activity.additionalData?['vehicleColor'] ??
                                  ''),
                    );
                  },
                ),
              ],
            );
          } else if (state is ActivityError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No activities found'));
        },
      ),
    );
  }
}
