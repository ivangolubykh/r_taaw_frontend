import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:r_taaw_frontend/auth/auth_provider.dart';
import 'package:r_taaw_frontend/core/constants/consts.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';
import 'package:r_taaw_frontend/theme/theme_provider.dart';

/// The main home screen of the app.
///
/// Displays a welcome message and app bar with authentication and theme
/// toggling. Includes a drawer for future settings navigation.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final loc = AppLocalizations.of(context)!;
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Text(
                loc.settingsTitle,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(
                '${loc.languageOption} (${AppConsts.languageFallbackLabel})',
              ),
              onTap: () {
                // TODO(ivangolubykh): Implement language change navigation.
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text(loc.welcomeText)),
    );
  }
}
