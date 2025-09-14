import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/core/widgets/custom_text_field.dart';
import 'package:cvms_mobile/features/auth/widgets/appbar/custom_appbar.dart';
import 'package:cvms_mobile/features/auth/widgets/buttons/custom_helper_link.dart';
import 'package:cvms_mobile/features/auth/widgets/texts/custom_heading.dart';
import 'package:cvms_mobile/features/auth/widgets/texts/custom_sub_heading.dart';
import 'package:cvms_mobile/features/auth/widgets/visuals/custom_illustration.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: Padding(
        padding: AppSpacing.horizontalLg,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSpacing.vXxl,
              Align(
                alignment: Alignment.center,
                child: CustomHeading(
                  heading: 'Forgot Password?',
                  fontSize: AppFontSizes.bodyLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CustomSubHeading(
                  subheading:
                      'Enter your registered email to receive\npassword reset link',
                  fontSize: AppFontSizes.bodySmall,
                  fontColor: AppColors.grey400,
                ),
              ),
              AppSpacing.vXxl,
              CustomIllustration(
                image: 'assets/images/forgotpass_illustration.png',
              ),
              AppSpacing.vXxl,
              CustomTextField(labelText: 'Email'),
              AppSpacing.vSm,
              CustomHelperLink(
                text: 'Remember password?',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                btnText: 'Login',
              ),
              AppSpacing.vSm,
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onSubmit: () {
                    //todo
                    Navigator.pushNamed(context, AppRoutes.emailSent);
                  },
                  btnText: 'Send',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
