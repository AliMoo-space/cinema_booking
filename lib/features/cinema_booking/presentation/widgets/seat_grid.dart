import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:cinema_booking/core/design_system/spacing/app_spacing.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_entity.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_widget.dart';

class SeatGrid extends StatelessWidget {
  const SeatGrid({super.key, required this.seats, required this.onSeatTap});

  final List<SeatEntity> seats;
  final ValueChanged<SeatEntity> onSeatTap;

  static const _seatCountPerSide = 5;
  static const _seatSize = 40.0;
  static const _rowLabelWidth = 24.0;
  static const _seatGap = AppSpacing.space8;
  static const _centerGap = AppSpacing.space64;

  @override
  Widget build(BuildContext context) {
    final seatsByRow = <String, List<SeatEntity>>{};

    for (final seat in seats) {
      seatsByRow.putIfAbsent(seat.row, () => []).add(seat);
    }

    final rows = seatsByRow.entries.toList()
      ..sort((first, second) => first.key.compareTo(second.key));

    return LayoutBuilder(
      builder: (context, constraints) {
        final topPadding = (MediaQuery.sizeOf(context).height * 0.04)
            .clamp(AppSpacing.space24, AppSpacing.space40)
            .toDouble();
        final seatGroupWidth =
            (_seatSize.w * _seatCountPerSide) +
            (_seatGap.w * (_seatCountPerSide - 1));
        final minimumMapWidth =
            _rowLabelWidth.w + _seatGap.w + (seatGroupWidth * 2) + _centerGap.w;
        final mapWidth = constraints.maxWidth > minimumMapWidth
            ? constraints.maxWidth
            : minimumMapWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(
            left: AppSpacing.space16.w,
            top: topPadding,
            right: AppSpacing.space16.w,
            bottom: AppSpacing.space16.h,
          ),
          child: SizedBox(
            width: mapWidth,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: rows.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSpacing.space16.h),
              itemBuilder: (context, index) {
                final row = rows[index];
                final rowSeats = [...row.value]
                  ..sort(
                    (first, second) => first.number.compareTo(second.number),
                  );
                final leftSeats = rowSeats.take(_seatCountPerSide).toList();
                final rightSeats = rowSeats
                    .skip(_seatCountPerSide)
                    .take(_seatCountPerSide)
                    .toList();

                return Row(
                  children: [
                    SizedBox(
                      width: _rowLabelWidth.w,
                      child: Text(row.key, style: AppTextStyles.labelMedium),
                    ),
                    SizedBox(width: _seatGap.w),
                    _SeatGroup(seats: leftSeats, onSeatTap: onSeatTap),
                    SizedBox(width: _centerGap.w),
                    _SeatGroup(seats: rightSeats, onSeatTap: onSeatTap),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _SeatGroup extends StatelessWidget {
  const _SeatGroup({required this.seats, required this.onSeatTap});

  final List<SeatEntity> seats;
  final ValueChanged<SeatEntity> onSeatTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < seats.length; index++) ...[
          if (index > 0) SizedBox(width: SeatGrid._seatGap.w),
          SeatWidget(seat: seats[index], onTap: () => onSeatTap(seats[index])),
        ],
      ],
    );
  }
}
