import 'package:cinema_booking/core/services/service_locator.dart';
import 'package:cinema_booking/features/cinema_booking/data/datasource/cinema_local_data_source.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_entity.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';
import 'package:cinema_booking/features/cinema_booking/domain/services/seat_selection_validator.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/cubit/cinema_booking_cubit.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/screens/cinema_booking_screen.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/booking_summary.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_grid.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_legend.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await sl.reset();
    await init();
  });

  tearDown(() async {
    await sl.reset();
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(375, 1400));
    await tester.pumpWidget(const MaterialApp(home: CinemaBookingScreen()));
    await tester.pumpAndSettle();
  }

  Finder seatFinder(String seatId) {
    return find.byWidgetPredicate(
      (widget) => widget is SeatWidget && widget.seat.id == seatId,
    );
  }

  Future<void> selectSeat(WidgetTester tester, String seatId) async {
    await tester.tap(seatFinder(seatId));
    await tester.pumpAndSettle();
  }

  testWidgets('displays all 60 seats and booking sections', (tester) async {
    await pumpScreen(tester);

    expect(find.text('Cinema Booking'), findsOneWidget);
    expect(find.text('Choose your seats for the movie'), findsOneWidget);
    expect(find.text('SCREEN'), findsOneWidget);
    expect(find.byType(SeatWidget), findsNWidgets(60));
    expect(find.byType(SeatGrid), findsOneWidget);
    expect(find.byType(SeatLegend), findsOneWidget);
    expect(find.byType(BookingSummary), findsOneWidget);
  });

  testWidgets('selecting an available seat updates count and total price', (
    tester,
  ) async {
    await pumpScreen(tester);

    await selectSeat(tester, 'C1');

    expect(find.text('1/5'), findsOneWidget);
    expect(find.text('50.00 EGP'), findsOneWidget);
    expect(seatFinder('C1'), findsOneWidget);
    expect(
      tester.widget<SeatWidget>(seatFinder('C1')).seat.status,
      SeatStatus.selected,
    );
  });

  testWidgets('selected seats can be unselected', (tester) async {
    await pumpScreen(tester);

    await selectSeat(tester, 'C1');
    await selectSeat(tester, 'C1');

    expect(find.text('0/5'), findsOneWidget);
    expect(find.text('0.00 EGP'), findsOneWidget);
    expect(
      tester.widget<SeatWidget>(seatFinder('C1')).seat.status,
      SeatStatus.available,
    );
  });

  testWidgets('reserved and disabled seats cannot be selected', (tester) async {
    await pumpScreen(tester);

    expect(
      find.descendant(of: seatFinder('A3'), matching: find.byType(InkWell)),
      findsNothing,
    );
    expect(
      find.descendant(of: seatFinder('D4'), matching: find.byType(InkWell)),
      findsNothing,
    );
    expect(find.text('0/5'), findsOneWidget);
  });

  testWidgets('does not allow selecting more than five seats', (tester) async {
    await pumpScreen(tester);

    for (final seatId in ['C1', 'C2', 'C3', 'C4', 'C5']) {
      await selectSeat(tester, seatId);
    }
    await selectSeat(tester, 'C6');

    expect(find.text('5/5'), findsOneWidget);
    expect(find.text('250.00 EGP'), findsOneWidget);
    expect(find.text('You can select up to 5 seats'), findsOneWidget);
    expect(
      tester.widget<SeatWidget>(seatFinder('C6')).seat.status,
      SeatStatus.available,
    );
  });

  testWidgets(
    'reset selection clears selected seats and keeps unavailable seats',
    (tester) async {
      await pumpScreen(tester);

      await selectSeat(tester, 'C1');
      await tester.tap(find.text('Reset Selection'));
      await tester.pumpAndSettle();

      expect(find.text('0/5'), findsOneWidget);
      expect(find.text('0.00 EGP'), findsOneWidget);
      expect(
        tester.widget<SeatWidget>(seatFinder('C1')).seat.status,
        SeatStatus.available,
      );
      expect(
        tester.widget<SeatWidget>(seatFinder('A3')).seat.status,
        SeatStatus.reserved,
      );
      expect(
        tester.widget<SeatWidget>(seatFinder('D4')).seat.status,
        SeatStatus.disabled,
      );
    },
  );

  testWidgets('displays the isolated available-seat validation error', (
    tester,
  ) async {
    await sl.reset();
    final seats = [
      SeatEntity(
        id: 'A1',
        row: 'A',
        number: 1,
        price: 50,
        status: SeatStatus.reserved,
      ),
      SeatEntity(
        id: 'A2',
        row: 'A',
        number: 2,
        price: 50,
        status: SeatStatus.selected,
      ),
      SeatEntity(
        id: 'A3',
        row: 'A',
        number: 3,
        price: 50,
        status: SeatStatus.disabled,
      ),
    ];
    sl.registerFactory<CinemaBookingCubit>(
      () => CinemaBookingCubit(
        dataSource: _TestCinemaDataSource(seats),
        validator: SeatSelectionValidator(),
      ),
    );

    await pumpScreen(tester);
    await selectSeat(tester, 'A2');

    expect(
      find.text('This action would leave an isolated available seat.'),
      findsOneWidget,
    );
    expect(find.text('1/5'), findsOneWidget);
  });
}

class _TestCinemaDataSource extends CinemaLocalDataSource {
  _TestCinemaDataSource(this.seats);

  final List<SeatEntity> seats;

  @override
  List<SeatEntity> getSeats() => seats;
}
