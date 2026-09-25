import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_radius.dart';
import 'package:cinema_booking/core/design_system/spacing/app_spacing.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:cinema_booking/core/design_system/widgets/text/app_text.dart';

enum AppButtonVariant { primary, secondary, outlined, text, danger }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.width,
    this.height = 56,
    this.backgroundColor,
    this.textStyle,
  });
  final Color? backgroundColor;
  final String text;

  final VoidCallback? onPressed;

  final AppButtonVariant variant;

  final bool enabled;

  final bool isLoading;

  final Widget? leading;

  final Widget? trailing;

  final double? width;

  final double height;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final style = _style(context);

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: style,
        onPressed: enabled && !isLoading ? onPressed : null,
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.onPrimary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) ...[leading!, Gap(AppSpacing.space8)],

                  AppText(
                    text,
                    style: (textStyle ?? AppTextStyles.titleLarge).copyWith(
                      color: style.foregroundColor?.resolve({}),
                    ),
                  ),

                  if (trailing != null) ...[Gap(AppSpacing.space8), trailing!],
                ],
              ),
      ),
    );
  }

  ButtonStyle _style(BuildContext context) {
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.radius16),
          ),
        );

      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.surfaceContainer,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.radius16),
          ),
        );

      case AppButtonVariant.outlined:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primary,
          elevation: 0,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.radius16),
          ),
        );

      case AppButtonVariant.text:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primary,
          elevation: 0,
          shadowColor: Colors.transparent,
        );

      case AppButtonVariant.danger:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.error,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.radius16),
          ),
        );
    }
  }
}
