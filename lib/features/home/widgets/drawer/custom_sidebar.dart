import 'package:cvms_mobile/core/theme/app_spacing.dart';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:cvms_mobile/features/home/widgets/drawer/custom_divider.dart';
import 'package:cvms_mobile/features/home/widgets/drawer/custom_list_tile.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_heading.dart';
import 'package:cvms_mobile/features/splash/widgets/texts/custom_sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:cvms_mobile/core/theme/app_font_sizes.dart';
import 'package:cvms_mobile/core/routes/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.white,
                    child: Image.asset("assets/images/jrmsu_logo.png"),
                  ),
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
            onTap: () {
              // todo add logout logic
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.login);
              // todo add logout logic
            },
          ),
        ],
      ),
    );
  }
}
