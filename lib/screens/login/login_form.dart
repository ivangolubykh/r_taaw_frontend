import 'package:flutter/material.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';

/// A login form using username and password.
class LoginForm extends StatefulWidget {
  /// Creates a [LoginForm] widget.
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO(ivangolubykh): Implement actual login API call.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logging in...')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: loc.usernameLabel),
            validator: (value) =>
                value != null && value.isNotEmpty ? null : loc.usernameInvalid,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: loc.passwordLabel),
            obscureText: true,
            validator: (value) => value != null && value.length >= 6
                ? null
                : loc.passwordTooShort,
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _submit, child: Text(loc.loginOption)),
        ],
      ),
    );
  }
}
