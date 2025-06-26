import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:r_taaw_frontend/auth/auth_provider.dart';
import 'package:r_taaw_frontend/core/constants/consts.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';
import 'package:r_taaw_frontend/theme/theme_provider.dart';
import 'package:r_taaw_frontend/widgets/navigation/breadcrumbs_bar.dart';
import 'package:r_taaw_frontend/widgets/navigation/breadcrumbs_meta.dart';

/// A reusable [AppBar] widget for the main layout.
///
/// Includes authentication toggle, theme switcher actions,
/// and an optional [BreadcrumbsBar] at the bottom.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [MainAppBar].
  const MainAppBar({super.key, this.breadcrumbs});

  /// Optional list of [BreadcrumbItem]s to show under the title.
  ///
  /// If not provided, breadcrumbs will be auto-generated from route metadata.
  final List<BreadcrumbItem>? breadcrumbs;

  @override
  Size get preferredSize => (breadcrumbs?.isNotEmpty ?? true)
      ? const Size.fromHeight(kToolbarHeight * 1.7)
      : const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final auth = Provider.of<AuthProvider>(context);
    final themeProvider = ThemeProvider.of(context);

    final state = GoRouterState.of(context);
    final resolved = breadcrumbs ?? resolveBreadcrumbsFromState(context, state);

    return AppBar(
      title: const Text(AppConsts.appTitle),
      actions: [
        IconButton(
          icon: Icon(auth.isAuthenticated ? Icons.logout : Icons.login),
          tooltip: auth.isAuthenticated ? loc.logoutOption : loc.loginOption,
          onPressed: () {
            if (auth.isAuthenticated) {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(loc.logoutConfirmTitle),
                  content: Text(loc.logoutConfirmMessage),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(loc.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        auth.clearTokens();
                      },
                      child: Text(loc.logoutOption),
                    ),
                  ],
                ),
              );
            } else {
              context.go('/login');
            }
          },
        ),
        IconButton(
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          tooltip: loc.themeSwitchOption,
          onPressed: themeProvider.toggleTheme,
        ),
      ],
      bottom: resolved.isNotEmpty ? BreadcrumbsBar(items: resolved) : null,
    );
  }
}
