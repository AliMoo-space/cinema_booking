import 'package:flutter/material.dart';
import 'package:cinema_booking/core/design_system/colors/app_colors.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageProvider,
    this.radius = 24,
    this.backgroundColor,
    this.child,
    this.borderColor,
    this.borderWidth = 1,
    this.onTap,
  });

  final ImageProvider? imageProvider;
  final double radius;
  final Color? backgroundColor;
  final Widget? child;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? AppColors.outlineVariant,
          width: borderWidth,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? AppColors.surfaceContainer,
        backgroundImage: imageProvider,
        child: imageProvider == null ? child : null,
      ),
    );

    if (onTap == null) {
      return avatar;
    }

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: avatar,
      ),
    );
  }
}
