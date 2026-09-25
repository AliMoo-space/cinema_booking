import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_entity.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_grid.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SeatEntity createSeat(String id, String row, int number) {
    return SeatEntity(
      id: id,
      row: row,
      number: number,
      price: 50,
      status: SeatStatus.available,
    );
  }

  testWidgets('groups rows and preserves seat order', (tester) async {
    final seats = [
      createSeat('B2', 'B', 2),
      createSeat('A10', 'A', 10),
      createSeat('B1', 'B', 1),
      createSeat('A1', 'A', 1),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SeatGrid(seats: seats, onSeatTap: (_) {}),
        ),
      ),
    );

    final displayedSeats = tester
        .widgetList<SeatWidget>(find.byType(SeatWidget))
        .map((widget) => widget.seat.id)
        .toList();

    expect(displayedSeats, ['A1', 'A10', 'B1', 'B2']);
  });

  testWidgets('forwards the tapped seat entity', (tester) async {
    final seat = createSeat('A1', 'A', 1);
    SeatEntity? tappedSeat;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SeatGrid(
            seats: [seat],
            onSeatTap: (selectedSeat) => tappedSeat = selectedSeat,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SeatWidget));

    expect(tappedSeat, same(seat));
  });

  testWidgets('uses one horizontal scroll container for the seat map', (
    tester,
  ) async {
    final seats = [
      for (final row in ['A', 'B', 'C', 'D', 'E', 'F'])
        for (var number = 1; number <= 10; number++)
          createSeat('$row$number', row, number),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SeatGrid(seats: seats, onSeatTap: (_) {}),
        ),
      ),
    );

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(SeatWidget), findsNWidgets(60));
  });
}
