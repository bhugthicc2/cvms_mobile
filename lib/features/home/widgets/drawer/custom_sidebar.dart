import 'package:cvms_mobile/core/theme/app_spacing.dart';
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
          //header
          Container(
            width: double.infinity,
            height: 230,
            padding: AppSpacing.paddingAllMd,
            decoration: BoxDecoration(
              color: AppColors.primary,
              image: DecorationImage(
                image: AssetImage('assets/images/sidebar_header_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.white,
                    child: Image.asset("assets/images/jrmsu_logo.png"),
                  ),
                  AppSpacing.vSm,
                  CustomHeading(
                    heading: 'JRMSU - K',
                    headingFontSize: AppFontSizes.bodyLarge,
                  ),
                  AppSpacing.vXxs,
                  CustomSubHeading(
                    subheading: 'CLOUD-BASED VEHICLE MONITORING SYSTEM',
                    subheadingFontSize: AppFontSizes.caption - 1,
                  ),
                ],
              ),
            ),
          ),

          //items
          _drawerItem(
            icon: PhosphorIconsBold.user,
            label: "Profile",
            onTap:
                () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.profile),
          ),
          Container(color: AppColors.grey300.withValues(alpha: 0.5), height: 1),
          _drawerItem(
            icon: PhosphorIconsBold.gearFine,
            label: "About",
            onTap: () => Navigator.pushNamed(context, AppRoutes.entryScan),
          ),
          Container(color: AppColors.grey300.withValues(alpha: 0.5), height: 1),
          _drawerItem(
            icon: PhosphorIconsBold.signOut,
            label: "Settings",
            onTap: () => Navigator.pushNamed(context, AppRoutes.exitScan),
          ),
          Container(color: AppColors.grey300.withValues(alpha: 0.5), height: 1),
          const Spacer(),
          _drawerItem(
            icon: PhosphorIconsBold.signOut,
            label: "Logout",
            color: Colors.red,
            onTap: () {
              Navigator.pop(context);
              // todo add logout logic
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,

    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.black, size: 22),
      trailing: Icon(
        PhosphorIconsBold.caretRight,
        color: color ?? AppColors.grey400,
        size: 22,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: AppFontSizes.bodySmall,
          fontWeight: FontWeight.w500,
          fontFamily: 'Sora',
          color: color ?? AppColors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}
