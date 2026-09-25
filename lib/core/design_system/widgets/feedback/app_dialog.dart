import 'package:flutter/material.dart';
import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_spacing.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:cinema_booking/core/design_system/widgets/text/app_text.dart';

final class AppDialog {
  const AppDialog._();

  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool barrierDismissible = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: AppColors.scrim,
      builder: (context) => _AppDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        isDestructive: true,
      ),
    );

    return result ?? false;
  }

  static Future<void> info(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return showDialog(
      context: context,
      barrierColor: AppColors.scrim,
      builder: (context) =>
          _AppDialog(title: title, message: message, confirmText: buttonText),
    );
  }

  static Future<void> error(
    BuildContext context, {
    String title = 'Something went wrong',
    required String message,
  }) {
    return info(context, title: title, message: message);
  }
}

class _AppDialog extends StatelessWidget {
  const _AppDialog({
    required this.title,
    required this.message,
    required this.confirmText,
    this.cancelText,
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmText;
  final String? cancelText;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: AppText(title, style: AppTextStyles.titleLarge),
      content: AppText(message, style: AppTextStyles.bodyMedium),
      actionsPadding: const EdgeInsets.all(AppSpacing.space16),
      actions: [
        if (cancelText != null)
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: AppText(cancelText!, color: AppColors.textSecondary),
          ),

        TextButton(
          child: AppText(confirmText, color: AppColors.error),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
