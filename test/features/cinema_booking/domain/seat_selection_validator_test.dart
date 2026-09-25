import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_entity.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';
import 'package:cinema_booking/features/cinema_booking/domain/services/seat_selection_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SeatSelectionValidator validator;
  late List<SeatEntity> seats;

  setUp(() {
    validator = SeatSelectionValidator();

    seats = [
      SeatEntity(
        id: 'A1',
        row: 'A',
        number: 1,
        price: 50,
        status: SeatStatus.available,
      ),
      SeatEntity(
        id: 'A2',
        row: 'A',
        number: 2,
        price: 50,
        status: SeatStatus.available,
      ),
      SeatEntity(
        id: 'A3',
        row: 'A',
        number: 3,
        price: 50,
        status: SeatStatus.available,
      ),
      SeatEntity(
        id: 'A4',
        row: 'A',
        number: 4,
        price: 50,
        status: SeatStatus.available,
      ),
      SeatEntity(
        id: 'A5',
        row: 'A',
        number: 5,
        price: 50,
        status: SeatStatus.available,
      ),
      SeatEntity(
        id: 'A6',
        row: 'A',
        number: 6,
        price: 50,
        status: SeatStatus.reserved,
      ),
      SeatEntity(
        id: 'A7',
        row: 'A',
        number: 7,
        price: 50,
        status: SeatStatus.disabled,
      ),
      SeatEntity(
        id: 'A8',
        row: 'A',
        number: 8,
        price: 50,
        status: SeatStatus.available,
      ),
    ];
  });

  test('returns invalid when seat does not exist', () {
    final result = validator.validate(seats: seats, seatId: 'Z99');

    expect(result.isValid, false);
    expect(result.errorMessage, 'Seat not found');
  });
  test('returns invalid when seat is reserved', () {
    final result = validator.validate(seats: seats, seatId: 'A6');

    expect(result.isValid, false);
    expect(result.errorMessage, 'This seat is reserved');
  });

  test('returns invalid when seat is disabled', () {
    final result = validator.validate(seats: seats, seatId: 'A7');

    expect(result.isValid, false);
    expect(result.errorMessage, 'This seat is disabled');
  });
  test('returns valid when selecting an available seat', () {
    final result = validator.validate(seats: seats, seatId: 'A1');

    expect(result.isValid, true);
    expect(result.errorMessage, isNull);
  });
  test('allows selecting the fifth seat', () {
    final testSeats = seats.map((seat) {
      if (seat.id == 'A1' ||
          seat.id == 'A2' ||
          seat.id == 'A3' ||
          seat.id == 'A4') {
        return seat.copyWith(status: SeatStatus.selected);
      }

      return seat;
    }).toList();

    final result = validator.validate(seats: testSeats, seatId: 'A5');

    expect(result.isValid, true);
  });
  test('rejects selecting more than five seats', () {
    final testSeats = seats.map((seat) {
      if (seat.id == 'A1' ||
          seat.id == 'A2' ||
          seat.id == 'A3' ||
          seat.id == 'A4' ||
          seat.id == 'A5') {
        return seat.copyWith(status: SeatStatus.selected);
      }

      return seat;
    }).toList();

    final result = validator.validate(seats: testSeats, seatId: 'A8');

    expect(result.isValid, false);
    expect(result.errorMessage, 'You can select up to 5 seats');
  });
  test(
    'rejects unselecting a seat when it leaves an isolated available seat',
    () {
      final testSeats = [
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

      final result = validator.validate(seats: testSeats, seatId: 'A2');

      expect(result.isValid, false);
      expect(
        result.errorMessage,
        'This action would leave an isolated available seat.',
      );
    },
  );
  test('allows selection when another available seat is already selected', () {
    final testSeats = [
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
        status: SeatStatus.available,
      ),
      SeatEntity(
        id: 'A3',
        row: 'A',
        number: 3,
        price: 50,
        status: SeatStatus.selected,
      ),
      SeatEntity(
        id: 'A4',
        row: 'A',
        number: 4,
        price: 50,
        status: SeatStatus.disabled,
      ),
    ];

    final result = validator.validate(seats: testSeats, seatId: 'A2');

    expect(result.isValid, true);
    expect(result.errorMessage, isNull);
  });
  test('allows unselecting a selected seat', () {
    final testSeats = [
      SeatEntity(
        id: 'A1',
        row: 'A',
        number: 1,
        price: 50,
        status: SeatStatus.available,
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
        status: SeatStatus.available,
      ),
    ];

    final result = validator.validate(seats: testSeats, seatId: 'A2');

    expect(result.isValid, true);
    expect(result.errorMessage, isNull);
  });
  test('allows available seat at the edge of a row', () {
  final testSeats = [
     SeatEntity(
      id: 'A1',
      row: 'A',
      number: 1,
      price: 50,
      status: SeatStatus.selected,
    ),
     SeatEntity(
      id: 'A2',
      row: 'A',
      number: 2,
      price: 50,
      status: SeatStatus.reserved,
    ),
     SeatEntity(
      id: 'A3',
      row: 'A',
      number: 3,
      price: 50,
      status: SeatStatus.available,
    ),
  ];

  final result = validator.validate(
    seats: testSeats,
    seatId: 'A3',
  );

  expect(result.isValid, true);
});
}
