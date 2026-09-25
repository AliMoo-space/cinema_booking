import 'package:cinema_booking/core/routing/app_routes.dart';
import 'package:cinema_booking/core/routing/page_transition.dart';
import 'package:cinema_booking/features/cinema_booking/presentation/screens/cinema_booking_screen.dart';
import 'package:go_router/go_router.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.cinemaBookingScreen,
    routes: [
    
      GoRoute(
        name: AppRoutes.cinemaBookingScreen,
        path: AppRoutes.cinemaBookingScreen,
        pageBuilder: (context, state) =>
            slideTransitionPage(state: state, child: const CinemaBookingScreen()),
      ),
     
    ],
  );
}
