import 'package:go_router/go_router.dart';
import 'package:r_taaw_frontend/screens/home_screen.dart';

/// Global router configuration using [GoRouter].
///
/// Add all application routes here.
/// To enable new routes, uncomment or add [GoRoute] entries.
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    // GoRoute(
    //   path: '/login',
    //   name: 'login',
    //   builder: (context, state) => const LoginScreen(),
    // ),
  ],
);
