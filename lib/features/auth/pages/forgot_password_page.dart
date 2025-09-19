import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/core/widgets/custom_text_field.dart';
import 'package:cvms_mobile/features/auth/widgets/appbar/custom_appbar.dart';
import 'package:cvms_mobile/features/auth/widgets/buttons/custom_helper_link.dart';
import 'package:cvms_mobile/features/auth/widgets/texts/custom_heading.dart';
import 'package:cvms_mobile/features/auth/widgets/texts/custom_sub_heading.dart';
import 'package:cvms_mobile/features/auth/widgets/visuals/custom_illustration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cvms_mobile/features/auth/bloc/forgot_password_cubit.dart';

import '../../../core/theme/app_spacing.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: Padding(
        padding: AppSpacing.horizontalLg,
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (_) => ForgotPasswordCubit(),
            child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                  BannerToast.show(
                    context,
                    message: 'Email sent successfully!',
                    type: BannerToastType.success,
                  );
                  Navigator.pushNamed(context, AppRoutes.emailSent);
                } else if (state is ForgotPasswordError) {
                  BannerToast.show(
                    context,
                    message: state.message,
                    type: BannerToastType.error,
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is ForgotPasswordLoading;
                return Form(
                  key: _formKey,
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
                      CustomTextField(
                        labelText: 'Email',
                        controller: _emailController,
                      ),
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
                          onSubmit:
                              isLoading
                                  ? () {}
                                  : () {
                                    final email = _emailController.text.trim();
                                    if (email.isEmpty) {
                                      BannerToast.show(
                                        context,
                                        message: 'Please enter your email',
                                        type: BannerToastType.error,
                                      );
                                      return;
                                    }
                                    context
                                        .read<ForgotPasswordCubit>()
                                        .sendReset(email);
                                  },
                          btnText: isLoading ? 'Sending...' : 'Send',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
