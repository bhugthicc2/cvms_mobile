import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:cvms_mobile/core/utils/number_formatter.dart';
import 'package:cvms_mobile/features/home/models/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomDonutChart extends StatelessWidget {
  final List<ChartModel> data;

  const CustomDonutChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = _calculateTotal();
    // empty data to display
    final displayData =
        total == 0 ? [ChartModel('No Data', 1, AppColors.grey300)] : data;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                data.map((item) {
                  final percent = NumberFormatter.percent(item.value, total);
                  final formattedValue = NumberFormatter.compact(item.value);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: item.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        AppSpacing.hXs,

                        SizedBox(
                          width: 50,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            item.category,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        AppSpacing.hXs,

                        Expanded(
                          child: SizedBox(
                            width: 26,
                            child: Text(
                              formattedValue,
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        AppSpacing.hXs,

                        Expanded(
                          child: SizedBox(
                            width: 27,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              percent,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),

        SizedBox(
          height: 140,
          width: 140,
          child: SfCircularChart(
            margin: EdgeInsets.zero,
            series: <DoughnutSeries<ChartModel, String>>[
              DoughnutSeries<ChartModel, String>(
                strokeColor: Colors.white,
                strokeWidth: 2,
                dataSource: displayData,
                xValueMapper: (ChartModel d, _) => d.category,
                yValueMapper: (ChartModel d, _) => d.value,
                pointColorMapper: (ChartModel d, _) => d.color,
                radius: '100%',
                innerRadius: '72%',
              ),
            ],
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.total,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.grey400),
                    ),
                    Text(
                      total.toString(),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int _calculateTotal() {
    return data.fold<int>(0, (sum, item) => sum + item.value.toInt());
  }
}
