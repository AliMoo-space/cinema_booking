import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_radius.dart';

enum AppIconButtonVariant { filled, outlined, ghost, danger }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = AppIconButtonVariant.filled,
    this.size = 48,
    this.iconSize = 22,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final double size;
  final double iconSize;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    // التغيير: جعلنا حجم الزر Responsive باستخدام .w.
    final double resolvedSize = size.w;

    // التغيير: جعلنا حجم الأيقونة Responsive باستخدام .sp.
    final double resolvedIconSize = iconSize.sp;

    final (backgroundColor, foregroundColor, borderColor) = switch (variant) {
      AppIconButtonVariant.filled => (
        AppColors.primary,
        AppColors.onPrimary,
        Colors.transparent,
      ),
      AppIconButtonVariant.outlined => (
        AppColors.surfaceLowest,
        AppColors.primary,
        AppColors.outlineVariant,
      ),
      AppIconButtonVariant.ghost => (
        Colors.transparent,
        AppColors.primary,
        Colors.transparent,
      ),
      AppIconButtonVariant.danger => (
        AppColors.error,
        AppColors.onError,
        Colors.transparent,
      ),
    };

    final button = Material(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radius16),
        side: BorderSide(
          color: borderColor,
          width: borderColor == Colors.transparent ? 0 : 1,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.radius16),
        child: SizedBox(
          width: resolvedSize,
          height: resolvedSize,
          child: Icon(icon, size: resolvedIconSize, color: foregroundColor),
        ),
      ),
    );

    // التغيير: لا نضيف Tooltip إلا لو تم تمرير قيمة فعلية.
    if (tooltip == null) {
      return button;
    }

    return Tooltip(message: tooltip!, child: button);
  }
}
