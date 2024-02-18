import 'package:admin_web_app/presentation/home/home_screen.dart';
import 'package:admin_web_app/presentation/sample/my_home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      name: 'counter',
      path: '/counter',
      builder: (_, __) => const MyHomePage(
        title: 'sample',
      ),
      routes: const [],
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (_, __) => const HomeScreen(),
      routes: const [],
    )
  ],
);
