import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:cvms_mobile/core/widgets/custom_app_bar.dart';
import 'package:cvms_mobile/core/widgets/custom_logo.dart';
import 'package:cvms_mobile/features/about/widgets/texts/body_text.dart';
import '../widgets/sections/section_title.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(pageTitle: 'About'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: AppSpacing.xl,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Center(child: CustomLogo(size: 100)),
              AppSpacing.vXl,
              // Title
              Text(
                AppStrings.appNameFull,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSizes.titleSmall,
                ),
              ),
              AppSpacing.vSm,
              // Subtitle
              Text(
                AppStrings.aboutInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w400,
                  fontSize: AppFontSizes.bodySmall,
                  color: AppColors.grey400,
                  height: 1.3,
                ),
              ),
              AppSpacing.vMd,
              // Version
              Text(
                'v1.1.0', //todo add the real app version
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w400,
                  fontSize: AppFontSizes.labelSmall,
                  color: AppColors.grey400,
                ),
              ),
              AppSpacing.vXl,
              // About this app
              SectionTitle('About this app'),
              AppSpacing.vSm,
              BodyText(AppStrings.about),
              AppSpacing.vMd,
              // Goal
              SectionTitle('Goal'),
              AppSpacing.vSm,
              BodyText(AppStrings.goal),
              AppSpacing.vMd,
              // Developers
              SectionTitle('Developers'),
              AppSpacing.vSm,
              BodyText(AppStrings.dev1),
              BodyText(AppStrings.dev2),
              BodyText(AppStrings.dev3),
              BodyText(AppStrings.dev4),
            ],
          ),
        ),
      ),
    );
  }
}
