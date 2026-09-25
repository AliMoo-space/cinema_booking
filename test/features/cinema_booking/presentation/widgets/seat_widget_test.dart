import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_entity.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SeatEntity createSeat(SeatStatus status) {
    return SeatEntity(id: 'A1', row: 'A', number: 1, price: 50, status: status);
  }

  Future<void> pumpSeatWidget(
    WidgetTester tester, {
    required SeatStatus status,
    required VoidCallback onTap,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SeatWidget(seat: createSeat(status), onTap: onTap),
        ),
      ),
    );
  }

  testWidgets('displays the seat number and forwards available taps', (
    tester,
  ) async {
    var tapCount = 0;
    await pumpSeatWidget(
      tester,
      status: SeatStatus.available,
      onTap: () => tapCount++,
    );

    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.text('1'));

    expect(tapCount, 1);
  });

  testWidgets('forwards selected taps', (tester) async {
    var tapCount = 0;
    await pumpSeatWidget(
      tester,
      status: SeatStatus.selected,
      onTap: () => tapCount++,
    );

    await tester.tap(find.text('1'));

    expect(tapCount, 1);
  });

  testWidgets('does not forward reserved or disabled taps', (tester) async {
    for (final status in [SeatStatus.reserved, SeatStatus.disabled]) {
      var tapCount = 0;
      await pumpSeatWidget(tester, status: status, onTap: () => tapCount++);

      await tester.tap(find.text('1'));

      expect(tapCount, 0);
    }
  });
}
