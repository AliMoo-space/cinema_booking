import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_radius.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_entity.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';

class SeatWidget extends StatelessWidget {
  const SeatWidget({super.key, required this.seat, required this.onTap});

  final SeatEntity seat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isTappable =
        seat.status == SeatStatus.available ||
        seat.status == SeatStatus.selected;

    final content = Container(
      width: 40.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.radius8.r),
        border: Border.all(color: _borderColor, width: 1.5.w),
      ),
      child: Text(
        '${seat.number}',
        style: AppTextStyles.labelLarge.copyWith(color: _textColor),
      ),
    );

    if (!isTappable) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.radius8.r),
        onTap: onTap,
        child: content,
      ),
    );
  }

  Color get _backgroundColor {
    switch (seat.status) {
      case SeatStatus.available:
        return AppColors.surface;
      case SeatStatus.selected:
        return AppColors.accent;
      case SeatStatus.reserved:
        return AppColors.warning.withValues(alpha: 0.18);
      case SeatStatus.disabled:
        return AppColors.disabled;
    }
  }

  Color get _borderColor {
    switch (seat.status) {
      case SeatStatus.available:
        return AppColors.secondary;
      case SeatStatus.selected:
        return AppColors.accent;
      case SeatStatus.reserved:
        return AppColors.warning;
      case SeatStatus.disabled:
        return AppColors.outlineVariant;
    }
  }

  Color get _textColor {
    switch (seat.status) {
      case SeatStatus.available:
        return AppColors.textPrimary;
      case SeatStatus.selected:
        return AppColors.onAccent;
      case SeatStatus.reserved:
        return AppColors.warning;
      case SeatStatus.disabled:
        return AppColors.textDisabled;
    }
  }
}
