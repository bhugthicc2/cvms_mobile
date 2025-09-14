import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/core/widgets/custom_checkbox.dart';
import 'package:cvms_mobile/core/widgets/custom_text_field.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_state.dart';
import 'package:cvms_mobile/features/auth/widgets/texts/custom_heading.dart';
import 'package:cvms_mobile/features/auth/widgets/texts/custom_sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _keepMeLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    final double headerHeight = MediaQuery.of(context).size.height * 0.25;
    final double logoRadius = 70;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            //todo
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome ${state.user.fullname}")),
            );
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
          if (state is AuthError) {
            //todo
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: headerHeight,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    Positioned(
                      top: headerHeight - logoRadius,
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: logoRadius,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/jrmsu_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: logoRadius),
                Padding(
                  padding: AppSpacing.paddingAllLg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomHeading(heading: AppStrings.loginHeading),
                      CustomSubHeading(subheading: AppStrings.loginSubHeading),
                      AppSpacing.vXxl,
                      // Email field
                      CustomTextField(
                        labelText: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      AppSpacing.vMd,
                      // Password field
                      CustomTextField(
                        labelText: 'Password',
                        isPassword: true,
                        controller: passwordController,
                      ),
                      AppSpacing.vMd,
                      //keep me logged & forgot pass
                      Row(
                        children: [
                          CustomCheckbox(
                            value: _keepMeLoggedIn,
                            onChanged: (value) {
                              setState(() {
                                _keepMeLoggedIn = value ?? false;
                              });
                            },
                          ),
                          AppSpacing.hXs,
                          Text(
                            'Keep me logged in',
                            style: TextStyle(
                              color: AppColors.grey400,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w600,
                              fontSize: AppFontSizes.labelSmall,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.forgotPass,
                              );
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: AppColors.grey400,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                                fontSize: AppFontSizes.labelSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.vLg,
                      // Login button
                      CustomButton(
                        onSubmit: () {
                          context.read<AuthCubit>().login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            keepMeLoggedIn: _keepMeLoggedIn,
                          );
                        },
                        btnText:
                            state is AuthLoading ? 'Logging in...' : 'Login',
                      ),
                      AppSpacing.vMd,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
