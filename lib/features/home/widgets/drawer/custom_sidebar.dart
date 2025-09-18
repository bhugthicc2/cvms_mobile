import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
import 'package:cvms_mobile/core/widgets/custom_logo.dart';
import 'package:cvms_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cvms_mobile/features/auth/widgets/dialogs/custom_logout_dialog.dart';
import 'package:cvms_mobile/features/home/widgets/drawer/custom_divider.dart';
import 'package:cvms_mobile/features/home/widgets/drawer/custom_list_tile.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_heading.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/routes/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _handleLogout(BuildContext context) {
    //todo add proper impl soon
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomLogoutDialog(
          onCancel: () => Navigator.of(dialogContext).pop(),
          onSubmit: () {
            Navigator.of(dialogContext).pop();
            _performLogout(context);
            BannerToast.show(
              context,
              message: 'Logged out successfully',
              type: BannerToastType.success,
            );
          },
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    Navigator.pop(context);
    context.read<AuthCubit>().signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      width: screenWidth * 0.8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      backgroundColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header dawg
          Container(
            width: double.infinity,
            height: 230,
            padding: AppSpacing.paddingAllMd,
            decoration: BoxDecoration(
              color: AppColors.primary,
              image: DecorationImage(
                image: const AssetImage('assets/images/sidebar_header_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomLogo(size: 75),
                  AppSpacing.vSm,
                  const CustomHeading(
                    heading: AppStrings.appName,
                    headingFontSize: AppFontSizes.bodyLarge,
                  ),
                  AppSpacing.vXxs,
                  const CustomSubHeading(
                    subheading: AppStrings.appInfo,
                    subheadingFontSize: AppFontSizes.caption - 1,
                  ),
                ],
              ),
            ),
          ),
          //list tiles
          CustomListTile(
            icon: PhosphorIconsBold.user,
            label: "Profile",
            onTap:
                () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.profile),
          ),
          const CustomDivider(),
          CustomListTile(
            icon: PhosphorIconsBold.info,
            label: "About",
            onTap: () => Navigator.pushNamed(context, AppRoutes.about),
          ),
          const CustomDivider(),
          CustomListTile(
            icon: PhosphorIconsBold.gearFine,
            label: "Settings",
            onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
          const CustomDivider(),
          const Spacer(),
          CustomListTile(
            icon: PhosphorIconsBold.signOut,
            label: "Logout",
            color: Colors.red,
            onTap: () => _handleLogout(context),
          ),
        ],
      ),
    );
  }
}
