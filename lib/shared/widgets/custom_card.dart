import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double elevation;
  final BorderRadius? borderRadius;

  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.onTap,
    this.elevation = 4,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
      ),
      color: backgroundColor ?? Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}