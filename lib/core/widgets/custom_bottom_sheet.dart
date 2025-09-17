import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/widgets/custom_report_button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onSubmit;
  final String submitText;
  final VoidCallback? onCancel;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.onSubmit,
    this.submitText = "Submit",
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(PhosphorIconsBold.warning, color: AppColors.primary),
              AppSpacing.hSm,
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Sora',
                  fontSize: AppFontSizes.bodyLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          AppSpacing.vLg,
          child,
          const SizedBox(height: 20),
          if (onSubmit != null)
            Row(
              children: [
                Expanded(
                  child: CustomReportButton(
                    bgColor: Colors.transparent,
                    isCancel: true,
                    onTap:
                        onCancel ??
                        () {
                          Navigator.pop(context);
                        },
                    btnText: 'Cancel',
                  ),
                ),
                AppSpacing.hLg,
                Expanded(
                  child: CustomReportButton(
                    bgColor: AppColors.primary,
                    isCancel: false,
                    onTap: onSubmit!,
                    btnText: 'Submit',
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
