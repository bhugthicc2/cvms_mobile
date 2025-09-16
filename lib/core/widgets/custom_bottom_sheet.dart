import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onSubmit;
  final String submitText;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.onSubmit,
    this.submitText = "Submit",
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
                  //todo separtate in a custom file
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(width: 1.5, color: AppColors.grey400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.grey400,
                          fontSize: AppFontSizes.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                AppSpacing.hLg,
                Expanded(
                  //todo separtate in a custom file
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppFontSizes.bodyMedium,
                        ),
                      ),
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
