import 'package:cinema_booking/features/cinema_booking/data/datasource/cinema_local_data_source.dart';
import 'package:cinema_booking/features/cinema_booking/domain/services/seat_selection_validator.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/cubit/cinema_booking_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CinemaBookingCubit cubit;

  setUp(() {
    cubit = CinemaBookingCubit(
      dataSource: CinemaLocalDataSource(),
      validator: SeatSelectionValidator(),
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  test('initial state contains 60 seats', () {
    expect(cubit.state.seats.length, 60);
  });

  test('selecting available seat changes its status to selected', () {
    cubit.selectSeat('C1');

    final seat = cubit.state.seats.firstWhere(
      (seat) => seat.id == 'C1',
    );

    expect(seat.status.name, 'selected');
  });

  test('selecting seat updates selected count and total price', () {
    cubit.selectSeat('C1');

    expect(cubit.state.selectedCount, 1);
    expect(cubit.state.totalPrice, 50);
  });

  test('selecting reserved seat keeps state unchanged and shows error', () {
    cubit.selectSeat('A3');

    final seat = cubit.state.seats.firstWhere(
      (seat) => seat.id == 'A3',
    );

    expect(seat.status.name, 'reserved');
    expect(cubit.state.selectedCount, 0);
    expect(cubit.state.errorMessage, 'This seat is reserved');
  });

  test('selecting disabled seat keeps state unchanged and shows error', () {
    cubit.selectSeat('D4');

    final seat = cubit.state.seats.firstWhere(
      (seat) => seat.id == 'D4',
    );

    expect(seat.status.name, 'disabled');
    expect(cubit.state.selectedCount, 0);
    expect(cubit.state.errorMessage, 'This seat is disabled');
  });

  test('reset selection changes selected seats back to available', () {
    cubit.selectSeat('C1');
    cubit.selectSeat('C2');

    expect(cubit.state.selectedCount, 2);

    cubit.resetSelection();

    expect(cubit.state.selectedCount, 0);

    final seatC1 = cubit.state.seats.firstWhere(
      (seat) => seat.id == 'C1',
    );

    final seatC2 = cubit.state.seats.firstWhere(
      (seat) => seat.id == 'C2',
    );

    expect(seatC1.status.name, 'available');
    expect(seatC2.status.name, 'available');
  });

  test('reset selection does not change reserved or disabled seats', () {
    cubit.resetSelection();

    final reservedSeat = cubit.state.seats.firstWhere(
      (seat) => seat.id == 'A3',
    );

    final disabledSeat = cubit.state.seats.firstWhere(
      (seat) => seat.id == 'D4',
    );

    expect(reservedSeat.status.name, 'reserved');
    expect(disabledSeat.status.name, 'disabled');
  });
}