import 'package:cinema_booking/features/cinema_booking/domain/entities/seat_status.dart';

class SeatEntity {
  final String id;
  final String row;
  final int number;
  final double price;
  final SeatStatus status;

  SeatEntity({
    required this.id,
    required this.row,
    required this.number,
    required this.price,
    required this.status,
  });

  SeatEntity copyWith({
    String? id,
    String? row,
    int? number,
    double? price,
    SeatStatus? status,
  }) {
    return SeatEntity(
      id: id ?? this.id,
      row: row ?? this.row,
      number: number ?? this.number,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }
}
