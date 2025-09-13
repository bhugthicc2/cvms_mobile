import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final double headerHeight;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final Widget? child;
  const CustomHeader({
    super.key,
    required this.headerHeight,
    required this.backgroundColor,
    required this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}
