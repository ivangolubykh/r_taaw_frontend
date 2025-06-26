import 'package:flutter/material.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';
import 'package:r_taaw_frontend/widgets/layout/main_app_bar.dart';
import 'package:r_taaw_frontend/widgets/layout/main_drawer.dart';

/// The main home screen of the app.
///
/// Displays a welcome message and app bar with authentication and theme
/// toggling. Includes a drawer for future settings navigation.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const MainAppBar(),
      drawer: const MainDrawer(),
      body: Center(child: Text(loc.welcomeText)),
    );
  }
}
