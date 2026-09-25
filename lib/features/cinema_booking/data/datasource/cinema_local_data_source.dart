import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_entity.dart';
import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';

class CinemaLocalDataSource {
  List<SeatEntity> getSeats() {
    final rows = ['A', 'B', 'C', 'D', 'E', 'F'];

    return [
      for (final row in rows)
        for (int number = 1; number <= 10; number++)
          () {
            final id = '$row$number';

            return SeatEntity(
              id: id,
              row: row,
              number: number,
              price: ['A', 'B', 'C'].contains(row) ? 50 : 70,
              status: id == 'A3' || id == 'B7'
                  ? SeatStatus.reserved
                  : id == 'D4' || id == 'E8'
                      ? SeatStatus.disabled
                      : SeatStatus.available,
            );
          }(),
    ];
  }
}

