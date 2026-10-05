import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_radius.dart';
import 'package:cinema_booking/core/design_system/spacing/app_spacing.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';

class SeatLegend extends StatelessWidget {
  const SeatLegend({super.key});

  static const double _minLegendWidth = 360;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final legendWidth = constraints.maxWidth < _minLegendWidth
            ? _minLegendWidth
            : constraints.maxWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: legendWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _LegendItem(
                  label: 'Available',
                  backgroundColor: AppColors.surface,
                  borderColor: AppColors.secondary,
                  textColor: AppColors.textPrimary,
                ),
                _LegendItem(
                  label: 'Selected',
                  backgroundColor: AppColors.accent,
                  borderColor: AppColors.accent,
                  textColor: AppColors.success,
                ),
                _LegendItem(
                  label: 'Reserved',
                  backgroundColor: AppColors.warning.withValues(alpha: 0.18),
                  borderColor: AppColors.warning,
                  textColor: AppColors.warning,
                ),
                _LegendItem(
                  label: 'Disabled',
                  backgroundColor: AppColors.disabled,
                  borderColor: AppColors.outlineVariant,
                  textColor: AppColors.textDisabled,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22.w,
          height: 22.w,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.radius8.r),
            border: Border.all(color: borderColor),
          ),
        ),
        SizedBox(width: AppSpacing.space8.w),
        Text(
          label,
          maxLines: 1,
          style: AppTextStyles.bodySmall.copyWith(color: textColor),
        ),
      ],
    );
  }
}
