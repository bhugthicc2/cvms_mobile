import 'package:cvms_mobile/core/routes/app_routes.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/core/widgets/custom_header.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_state.dart';
import 'package:cvms_mobile/features/auth/widgets/dialogs/custom_logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'package:cvms_mobile/features/profile/widgets/custom_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _fullnameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _fullnameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomLogoutDialog(
          onCancel: () => Navigator.of(dialogContext).pop(),
          onSubmit: () {
            Navigator.of(dialogContext).pop();
            _performLogout(context);
          },
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    context.read<AuthCubit>().signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final headerHeight = size.height * 0.29;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Get the current user from the cubit
        final currentUser = state is AuthAuthenticated ? state.user : null;
        // Update controllers with user data
        if (currentUser != null) {
          _fullnameController.text = currentUser.fullname;
          _emailController.text = currentUser.email;
        }
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(
            pageTitle: 'Profile',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.home);
            },
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: headerHeight,
                child: CustomHeader(
                  headerHeight: headerHeight,
                  backgroundColor: AppColors.primary,
                  padding: AppSpacing.homePadding,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: AppColors.white,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 10,
                                    color: AppColors.primary,
                                  ),
                                ),
                                child: CircleAvatar(
                                  child: Image.asset(
                                    'assets/images/profile.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                padding: AppSpacing.paddingAllXxs,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 4,
                                    color: AppColors.white,
                                  ),
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                                child: Icon(
                                  PhosphorIconsFill.camera,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, -25),
                  child: SizedBox(
                    child: Padding(
                      padding: AppSpacing.horizontalLg,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            labelText: 'Fullname',
                            controller: _fullnameController,
                            readOnly: true,
                          ),
                          AppSpacing.vLg,
                          CustomTextField(
                            labelText: 'Email',
                            controller: _emailController,
                            readOnly: true,
                          ),
                          Spacer(),
                          CustomButton(
                            onSubmit: () => _handleLogout(context),
                            btnText: 'Logout',
                            btnColor: AppColors.error,
                          ),
                          AppSpacing.vLg,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
