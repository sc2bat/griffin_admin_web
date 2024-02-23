import 'package:admin_web_app/di/di_setup.dart';
import 'package:admin_web_app/ui/airports/airports_screen.dart';
import 'package:admin_web_app/ui/sample/my_home_page.dart';
import 'package:admin_web_app/ui/splash/index_screen.dart';
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
      builder: (_, __) => const IndexScreen(),
      routes: const [],
    ),
    GoRoute(
      name: 'dashboard',
      path: '/dashboard',
      builder: (_, __) => const IndexScreen(),
      routes: const [],
    ),
    GoRoute(
      name: 'flights',
      path: '/flights',
      builder: (_, __) => const MyHomePage(
        title: 'flights',
      ),
      routes: [
        GoRoute(
          name: 'flightDetail',
          path: 'flightDetail',
          builder: (_, __) => const MyHomePage(
            title: 'flightDetail',
          ),
          routes: const [],
        ),
      ],
    ),
    GoRoute(
      name: 'airports',
      path: '/airports',
      builder: (_, __) => const AirportsScreen(),
      routes: const [],
    ),
    GoRoute(
      name: 'reservation',
      path: '/reservation',
      builder: (_, __) => const MyHomePage(
        title: 'reservation',
      ),
      routes: const [],
    ),
    GoRoute(
      name: 'usermanage',
      path: '/usermanage',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<UserViewModel>(),
        child: const UserScreen(),
      ),
      routes: [
        GoRoute(
          name: 'userDetail',
          path: 'userDetail',
          builder: (_, __) => const MyHomePage(
            title: 'userDetail',
          ),
          routes: const [],
        ),
      ],
    ),
    GoRoute(
      name: 'payment',
      path: '/payment',
      builder: (_, __) => const MyHomePage(
        title: 'payment',
      ),
      routes: [
        GoRoute(
          name: 'paymentDetail',
          path: 'paymentDetail',
          builder: (_, __) => const MyHomePage(
            title: 'paymentDetail',
          ),
          routes: const [],
        ),
      ],
    ),
  ],
);
