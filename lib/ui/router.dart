import 'package:admin_web_app/di/di_setup.dart';
import 'package:admin_web_app/ui/airports/airports_screen.dart';
import 'package:admin_web_app/ui/airports/airports_view_model.dart';
import 'package:admin_web_app/ui/book/book_screen.dart';
import 'package:admin_web_app/ui/book/book_view_model.dart';
import 'package:admin_web_app/ui/book/detail/book_detail_screen.dart';
import 'package:admin_web_app/ui/book/detail/book_detail_view_model.dart';
import 'package:admin_web_app/ui/dashboard/dashboard_screen.dart';
import 'package:admin_web_app/ui/dashboard/dashboard_view_model.dart';
import 'package:admin_web_app/ui/flights/detail/flight_detail_screen.dart';
import 'package:admin_web_app/ui/flights/detail/flight_detail_view_model.dart';
import 'package:admin_web_app/ui/flights/flights_screen.dart';
import 'package:admin_web_app/ui/flights/flights_view_model.dart';
import 'package:admin_web_app/ui/sign/sign_screen.dart';
import 'package:admin_web_app/ui/sign/sign_view_model.dart';
import 'package:admin_web_app/ui/splash/splash_screen.dart';
import 'package:admin_web_app/ui/splash/splash_view_model.dart';
import 'package:admin_web_app/ui/user/user_screen.dart';
import 'package:admin_web_app/ui/user/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<SplashViewModel>(),
        child: const SplashScreen(),
      ),
      routes: const [],
    ),
    GoRoute(
      name: 'sign',
      path: '/sign',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<SignViewModel>(),
        child: const SignScreen(),
      ),
      routes: const [],
    ),
    GoRoute(
      name: 'dashboard',
      path: '/dashboard',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<DashboardViewModel>(),
        child: const DashboardScreen(),
      ),
      routes: const [],
    ),
    GoRoute(
      name: 'flights',
      path: '/flights',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<FlightsViewModel>(),
        child: const FlightsScreen(),
      ),
      routes: [
        GoRoute(
          name: 'flightDetail',
          path: 'flightDetail',
          builder: (_, state) {
            final flightDetailMap = state.extra! as Map<String, dynamic>;
            return ChangeNotifierProvider(
              create: (_) => getIt<FlightDetailViewModel>(),
              child: FlightDetailScreen(
                flightsModel: flightDetailMap['flightsModel'],
                departureAirportModel: flightDetailMap['departureAirportModel'],
                arrivalAirportModel: flightDetailMap['arrivalAirportModel'],
              ),
            );
          },
          routes: const [],
        ),
      ],
    ),
    GoRoute(
      name: 'airports',
      path: '/airports',
      builder: (_, __) {
        return ChangeNotifierProvider(
          create: (_) => getIt<AirportsViewModel>(),
          child: const AirportsScreen(),
        );
      },
      routes: const [],
    ),
    GoRoute(
      name: 'book',
      path: '/book',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<BookViewModel>(),
        child: const BookScreen(),
      ),
      routes: [
        GoRoute(
          name: 'book_detail',
          path: 'detail',
          builder: (_, state) {
            final bookDetailMap = state.extra! as Map<String, dynamic>;
            return ChangeNotifierProvider(
              create: (_) => getIt<BookDetailViewModel>(),
              child: BookDetailScreen(
                bookId: bookDetailMap['bookId'],
              ),
            );
          },
          routes: const [],
        ),
      ],
    ),
    GoRoute(
      name: 'user',
      path: '/user',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<UserViewModel>(),
        child: const UserScreen(),
      ),
      routes: [
        GoRoute(
          name: 'detail',
          path: 'detail',
          builder: (_, state) {
            final map = state.extra! as Map<String, dynamic>;
            return ChangeNotifierProvider(
              create: (_) => getIt<UserViewModel>(),
              child: BookDetailScreen(
                bookId: map["book_id"],
              ),
            );
          },
        ),
      ],
    ),
  ],
);
