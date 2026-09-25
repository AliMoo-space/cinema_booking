// AppSection(
//   title: 'Profile',
//   subtitle: 'Manage your account information',
//   child: AppCard(
//     child: Text('Content'),
//   ),
// )

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_spacing.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:cinema_booking/core/design_system/widgets/text/app_text.dart';

class AppSection extends StatelessWidget {
  const AppSection({
    super.key,
    this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.padding,
    this.spacing = AppSpacing.space16,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String? title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          if (title != null || trailing != null)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        AppText(title!, style: AppTextStyles.titleLarge),

                      if (subtitle != null) ...[
                        const Gap(AppSpacing.space4),
                        AppText(
                          subtitle!,
                          style: AppTextStyles.bodySmall,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ],
                  ),
                ),

                ?trailing,
              ],
            ),

          if (title != null || trailing != null) Gap(spacing),

          child,
        ],
      ),
    );
  }
}
