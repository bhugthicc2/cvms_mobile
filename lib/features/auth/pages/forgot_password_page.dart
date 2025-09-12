import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/core/widgets/custom_text_field.dart';
import 'package:cvms_mobile/features/auth/widgets/appbar/custom_appbar.dart';
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
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: AppFontSizes.bodyLarge,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  'Enter your registered email to receive\npassword reset link',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: AppFontSizes.bodySmall,
                    color: AppColors.grey400,
                  ),
                ),
              ),
              AppSpacing.vXxl,
              Image.asset(
                'assets/images/forgotpass_illustration.png',
                fit: BoxFit.cover,
              ),
              AppSpacing.vXxl,
              CustomTextField(labelText: 'Email'),
              AppSpacing.vSm,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Remember password?',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: AppFontSizes.bodySmall,
                      color: AppColors.grey400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //todo
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: AppFontSizes.bodySmall,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
