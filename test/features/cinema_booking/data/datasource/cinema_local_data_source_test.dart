import 'package:cinema_booking/features/cinema_booking/data/datasource/cinema_local_data_source.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CinemaLocalDataSource dataSource;

  setUp(() {
    dataSource = CinemaLocalDataSource();
  });

  test('returns 60 seats', () {
    final seats = dataSource.getSeats();

    expect(seats.length, 60);
  });

  test('returns correct prices for each row', () {
    final seats = dataSource.getSeats();

    final cheapSeats = seats.where(
      (seat) => ['A', 'B', 'C'].contains(seat.row),
    );

    final expensiveSeats = seats.where(
      (seat) => ['D', 'E', 'F'].contains(seat.row),
    );

    expect(cheapSeats.every((seat) => seat.price == 50), true);
    expect(expensiveSeats.every((seat) => seat.price == 70), true);
  });

  test('returns correct reserved and disabled seats', () {
    final seats = dataSource.getSeats();

    final reservedSeats = seats.where(
      (seat) => seat.status == SeatStatus.reserved,
    );

    final disabledSeats = seats.where(
      (seat) => seat.status == SeatStatus.disabled,
    );

    expect(reservedSeats.map((seat) => seat.id), containsAll(['A3', 'B7']));
    expect(disabledSeats.map((seat) => seat.id), containsAll(['D4', 'E8']));
  });
}