import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/features/auth/widgets/appbar/custom_appbar.dart';
import 'package:cvms_mobile/features/auth/widgets/buttons/custom_helper_link.dart';
import 'package:cvms_mobile/features/auth/widgets/texts/custom_heading.dart';
import 'package:cvms_mobile/features/auth/widgets/texts/custom_sub_heading.dart';
import 'package:cvms_mobile/features/auth/widgets/visuals/custom_illustration.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      PhosphorIconsFill.checkCircle,
                      color: AppColors.success,
                    ),
                    AppSpacing.hXs,
                    CustomHeading(
                      heading: 'Email has been sent',
                      fontSize: AppFontSizes.bodyLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CustomSubHeading(
                  subheading:
                      'Please check your inbox and click in the\n received link to reset your password.',
                  fontSize: AppFontSizes.bodySmall,
                  fontColor: AppColors.grey400,
                ),
              ),

              AppSpacing.vXxl,

              CustomIllustration(
                image: 'assets/images/emailsent_illustration.png',
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
              CustomHelperLink(
                text: "Didn't receive link",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.forgotPass);
                },
                btnText: 'Resend',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
