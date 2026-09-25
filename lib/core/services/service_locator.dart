import 'package:cinema_booking/features/cinema_booking/data/datasource/cinema_local_data_source.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/cubit/cinema_booking_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:cinema_booking/features/cinema_booking/domain/services/seat_selection_validator.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // =============================================
  // External Dependencies
  // =============================================

  // =============================================
  // Data Layer
  // =============================================

  sl.registerLazySingleton<CinemaLocalDataSource>(
    () => CinemaLocalDataSource(),
  );

  // =============================================
  // Domain Layer
  // =============================================

  sl.registerLazySingleton<SeatSelectionValidator>(
    () => SeatSelectionValidator(),
  );

  // =============================================
  // Use Cases
  // =============================================

  // =============================================
  // Presentation Layer
  // =============================================
sl.registerFactory<CinemaBookingCubit>(
  () => CinemaBookingCubit(
    dataSource: sl(),
    validator: sl(),
  ),
);
  // =============================================
  // Localization
  // =============================================
}