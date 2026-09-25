import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_entity.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';

class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult.valid() : isValid = true, errorMessage = null;

  const ValidationResult.invalid(this.errorMessage) : isValid = false;
}

class SeatSelectionValidator {
  static const int maxSelectedSeats = 5;

  ValidationResult validate({
    required List<SeatEntity> seats,
    required String seatId,
  }) {
    SeatEntity? selectedSeat;

    for (final seat in seats) {
      if (seat.id == seatId) {
        selectedSeat = seat;
        break;
      }
    }

    if (selectedSeat == null) {
      return const ValidationResult.invalid('Seat not found');
    }

    if (selectedSeat.status == SeatStatus.reserved) {
      return const ValidationResult.invalid('This seat is reserved');
    }

    if (selectedSeat.status == SeatStatus.disabled) {
      return const ValidationResult.invalid('This seat is disabled');
    }

    final selectedSeatCount = seats
        .where((seat) => seat.status == SeatStatus.selected)
        .length;
    if (selectedSeat.status == SeatStatus.available &&
        selectedSeatCount >= maxSelectedSeats) {
      return const ValidationResult.invalid('You can select up to 5 seats');
    }

    final proposedSeats = seats.map((seat) {
      if (seat.id != seatId) {
        return seat;
      }
      return seat.copyWith(
        status: seat.status == SeatStatus.available
            ? SeatStatus.selected
            : SeatStatus.available,
      );
    }).toList();

    for (int i = 1; i < proposedSeats.length - 1; i++) {
      final previous = proposedSeats[i - 1];
      final current = proposedSeats[i];
      final next = proposedSeats[i + 1];

      if (current.row == previous.row &&
          current.row == next.row &&
          current.status == SeatStatus.available &&
          previous.status != SeatStatus.available &&
          next.status != SeatStatus.available) {
        return const ValidationResult.invalid(
          'This action would leave an isolated available seat.',
        );
      }
    }
    return const ValidationResult.valid();
  }
}
