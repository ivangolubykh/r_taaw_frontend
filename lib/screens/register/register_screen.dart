import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:r_taaw_frontend/screens/register/register_form.dart';
import 'package:r_taaw_frontend/widgets/layout/main_app_bar.dart';

/// Screen that displays the registration form.
///
/// Provides consistent padding and app bar layout.
class RegisterScreen extends StatelessWidget {
  /// Creates a [RegisterScreen].
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: RegisterForm(onSuccess: () => context.go('/')),
        ),
      ),
    );
  }
}
