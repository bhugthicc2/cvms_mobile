import 'package:cvms_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final double headerHeight;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  const CustomHeader({
    super.key,
    required this.headerHeight,
    this.backgroundColor,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );
  }
}
