
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_entity.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';

class CinemaBookingState {
  final List<SeatEntity> seats;
  final String? errorMessage;

  const CinemaBookingState({
    required this.seats,
    this.errorMessage,
  });

  int get selectedCount {
    return seats
        .where((seat) => seat.status == SeatStatus.selected)
        .length;
  }

  double get totalPrice {
    return seats
        .where((seat) => seat.status == SeatStatus.selected)
        .fold(0, (total, seat) => total + seat.price);
  }

  CinemaBookingState copyWith({
    List<SeatEntity>? seats,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CinemaBookingState(
      seats: seats ?? this.seats,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}