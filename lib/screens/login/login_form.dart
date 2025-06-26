import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:r_taaw_frontend/api/auth_api.dart';
import 'package:r_taaw_frontend/auth/auth_provider.dart';
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
  bool _isSubmitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final loc = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final authApi = Provider.of<AuthApi>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final response = await authApi.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );
      await authProvider.setTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(loc.loginSuccess)));
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(loc.loginFailed)));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
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
            validator: (value) =>
                value != null && value.isNotEmpty ? null : loc.passwordRequired,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isSubmitting ? null : _submit,
            child: Text(_isSubmitting ? loc.loggingIn : loc.loginOption),
          ),
        ],
      ),
    );
  }
}
