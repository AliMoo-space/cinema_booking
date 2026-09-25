import 'package:cinema_booking/features/cinema_booking/data/datasource/cinema_local_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';
import 'package:cinema_booking/features/cinema_booking/domain/services/seat_selection_validator.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/cubit/cinema_booking_state.dart';

class CinemaBookingCubit extends Cubit<CinemaBookingState> {
  final CinemaLocalDataSource dataSource;
  final SeatSelectionValidator validator;

  CinemaBookingCubit({
    required this.dataSource,
    required this.validator,
  }) : super(
          CinemaBookingState(
            seats: dataSource.getSeats(),
          ),
        );

  void selectSeat(String seatId) {
    final validationResult = validator.validate(
      seats: state.seats,
      seatId: seatId,
    );

    if (!validationResult.isValid) {
      emit(
        state.copyWith(
          errorMessage: validationResult.errorMessage,
        ),
      );
      return;
    }

    final updatedSeats = state.seats.map((seat) {
      if (seat.id != seatId) {
        return seat;
      }

      return seat.copyWith(
        status: seat.status == SeatStatus.available
            ? SeatStatus.selected
            : SeatStatus.available,
      );
    }).toList();

    emit(
      state.copyWith(
        seats: updatedSeats,
        clearError: true,
      ),
    );
  }

  void resetSelection() {
    final resetSeats = state.seats.map((seat) {
      if (seat.status == SeatStatus.selected) {
        return seat.copyWith(
          status: SeatStatus.available,
        );
      }

      return seat;
    }).toList();

    emit(
      state.copyWith(
        seats: resetSeats,
        clearError: true,
      ),
    );
  }

  void clearError() {
    emit(
      state.copyWith(
        clearError: true,
      ),
    );
  }
}