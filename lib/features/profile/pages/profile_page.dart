import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/widgets/custom_button.dart';
import 'package:cvms_mobile/core/widgets/custom_header.dart';
import 'package:cvms_mobile/features/profile/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final headerHeight = size.height * 0.29;

    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: CustomAppBar(pageTitle: 'Profile'),
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
                      CustomTextField(labelText: 'Fullname'),
                      AppSpacing.vLg,
                      CustomTextField(labelText: 'Email'),
                      Spacer(),
                      CustomButton(
                        onSubmit: () {},
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
  }
}
