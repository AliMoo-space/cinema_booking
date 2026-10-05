import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_radius.dart';
import 'package:cinema_booking/core/design_system/spacing/app_spacing.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:cinema_booking/features/cinema_booking/domain/services/seat_selection_validator.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/cubit/cinema_booking_cubit.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/cubit/cinema_booking_state.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/booking_summary.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_grid.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_legend.dart';

class CinemaBookingScreen extends StatelessWidget {
  const CinemaBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CinemaBookingCubit, CinemaBookingState>(
        builder: (context, state) {
          final cubit = context.read<CinemaBookingCubit>();

          return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallHeight = constraints.maxHeight < 700;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppSpacing.space16.w,
                        top: isSmallHeight ? 24.h : AppSpacing.space48.h,
                        right: AppSpacing.space16.w,
                        bottom: AppSpacing.space8.h,
                      ),
                      child: Text(
                        'Choose your seats for the movie',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.space16.w,
                      ),
                      child: const _CinemaScreenIndicator(),
                    ),

                    if (state.errorMessage != null)
                      Padding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.space16.w,
                          top: AppSpacing.space12.h,
                          right: AppSpacing.space16.w,
                        ),
                        child: _ValidationError(
                          message: state.errorMessage!,
                        ),
                      ),

                    // SeatGrid takes all remaining space.
                    Expanded(
                      child: SeatGrid(
                        seats: state.seats,
                        onSeatTap: (seat) => cubit.selectSeat(seat.id),
                      ),
                    ),

                    // Fixed bottom section.
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.space16.w,
                      ),
                      child: const SeatLegend(),
                    ),

                    Padding(
                      padding: EdgeInsets.all(
                        isSmallHeight
                            ? AppSpacing.space8.w
                            : AppSpacing.space16.w,
                      ),
                      child: BookingSummary(
                        selectedCount: state.selectedCount,
                        maxSeats: SeatSelectionValidator.maxSelectedSeats,
                        totalPrice: state.totalPrice,
                        onReset: cubit.resetSelection,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _CinemaScreenIndicator extends StatelessWidget {
  const _CinemaScreenIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 48,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.primary,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.movie_outlined,
            size: 18.sp,
            color: AppColors.primary,
          ),
          SizedBox(width: 8.w),
          Text(
            'SCREEN',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ValidationError extends StatelessWidget {
  const _ValidationError({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppSpacing.space12.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(
          AppRadius.radius8.r,
        ),
        border: Border.all(
          color: AppColors.error,
        ),
      ),
      child: Text(
        message,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.error,
        ),
      ),
    );
  }
}