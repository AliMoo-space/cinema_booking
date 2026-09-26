import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_spacing.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:cinema_booking/core/design_system/widgets/buttons/app_button.dart';
import 'package:cinema_booking/core/design_system/widgets/layout/app_card.dart';

class BookingSummary extends StatelessWidget {
  const BookingSummary({
    super.key,
    required this.selectedCount,
    required this.maxSeats,
    required this.totalPrice,
    required this.onReset,
  });

  final int selectedCount;
  final int maxSeats;
  final double totalPrice;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(AppSpacing.space16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _SummaryMetric(
                  label: 'Selected seats',
                  value: '$selectedCount/$maxSeats',
                ),
              ),
              Expanded(
                child: _SummaryMetric(
                  label: 'Total price',
                  value: '${totalPrice.toStringAsFixed(2)} EGP',
                  valueColor: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.space16.h),
          AppButton(
            text: 'Reset Selection',
            onPressed: onReset,
            variant: AppButtonVariant.outlined,
            height: 48.h,
            textStyle: AppTextStyles.labelLarge,
          ),
        ],
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodySmall),
        SizedBox(height: AppSpacing.space4.h),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
