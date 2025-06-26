import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';
import 'package:r_taaw_frontend/screens/login/login_form.dart';
import 'package:r_taaw_frontend/widgets/layout/main_app_bar.dart';
import 'package:r_taaw_frontend/widgets/layout/main_drawer.dart';

/// A screen where users can log into their account.
///
/// Displays a [LoginForm] and a link to navigate to the registration screen.
class LoginScreen extends StatelessWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const MainAppBar(),
      drawer: const MainDrawer(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginForm(),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.go('/register'),
                      child: Text(loc.registerLinkText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
