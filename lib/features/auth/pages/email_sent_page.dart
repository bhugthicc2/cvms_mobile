import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/features/auth/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';

class EmailSentPage extends StatelessWidget {
  const EmailSentPage({super.key});

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
              AppSpacing.vXxl,
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Email has been sent',
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
                  'Please check your inbox and click inthe\n received link to reset your password.',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: AppFontSizes.bodySmall,
                    color: AppColors.grey400,
                  ),
                ),
              ),
              AppSpacing.vXxl,
              Image.asset(
                'assets/images/emailsent_illustration.png',
                fit: BoxFit.cover,
              ),
              AppSpacing.vXxl,
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onSubmit: () {
                    //todo
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  btnText: 'Login',
                ),
              ),
              AppSpacing.vSm,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Didn't receive link?",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: AppFontSizes.bodySmall,
                      color: AppColors.grey400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //todo
                      Navigator.pushNamed(context, AppRoutes.forgotPass);
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Resend',
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
            ],
          ),
        ),
      ),
    );
  }
}
