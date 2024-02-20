import 'package:admin_web_app/presentation/sample/my_home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (_, __) => const MyHomePage(
        title: 'splash',
      ),
      routes: const [],
    ),
    GoRoute(
      name: 'dashboard',
      path: '/dashboard',
      builder: (_, __) => const MyHomePage(
        title: 'dashboard',
      ),
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
      builder: (_, __) => const MyHomePage(
        title: 'airports',
      ),
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
      builder: (_, __) => const MyHomePage(
        title: 'usermanage',
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
