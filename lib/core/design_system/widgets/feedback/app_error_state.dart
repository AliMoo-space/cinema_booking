import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_spacing.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:cinema_booking/core/design_system/widgets/buttons/app_button.dart';
import 'package:cinema_booking/core/design_system/widgets/text/app_text.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.buttonText = 'Retry',
  });

  final String message;
  final VoidCallback? onRetry;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 56, color: AppColors.error),
            const Gap(AppSpacing.space16),
            AppText(
              message,
              style: AppTextStyles.bodyMedium,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const Gap(AppSpacing.space24),
              AppButton(text: buttonText, onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}
