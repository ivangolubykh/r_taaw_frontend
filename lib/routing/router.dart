import 'package:go_router/go_router.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';
import 'package:r_taaw_frontend/screens/home_screen.dart';
import 'package:r_taaw_frontend/screens/login/login_screen.dart';
import 'package:r_taaw_frontend/screens/register/register_screen.dart';
import 'package:r_taaw_frontend/widgets/navigation/breadcrumbs_meta.dart';

/// Global router configuration using [GoRouter].
///
/// All routes should include `.withBreadcrumb(...)`
/// to enable breadcrumb support.
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ).withBreadcrumb(
      BreadcrumbMeta.static(
        label: (context) => AppLocalizations.of(context)!.breadcrumbHome,
      ),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ).withBreadcrumb(
      BreadcrumbMeta.static(
        parentName: 'home',
        label: (context) => AppLocalizations.of(context)!.loginOption,
      ),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ).withBreadcrumb(
      BreadcrumbMeta.static(
        parentName: 'home',
        label: (context) => AppLocalizations.of(context)!.registerOption,
      ),
    ),
  ],
);
