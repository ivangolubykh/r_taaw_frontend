import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';
import 'package:r_taaw_frontend/screens/login/login_form.dart';
import 'package:r_taaw_frontend/widgets/layout/main_app_bar.dart';

/// Screen for user login.
///
/// Displays the login form and a link to the registration screen.
class LoginScreen extends StatelessWidget {
  /// Creates a [LoginScreen] widget.
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const MainAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LoginForm(),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/register'),
                child: Text(loc.registerLinkText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
