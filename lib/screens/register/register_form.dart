import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_taaw_frontend/api/auth_api.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';
import 'package:r_taaw_frontend/widgets/ui/help_dialog.dart';
import 'package:r_taaw_frontend/widgets/ui/show_app_snack_bar.dart';

/// A registration form for new users.
///
/// Contains fields for username, password, email, and nickname.
/// Shows contextual help dialogs and error messages.
class RegisterForm extends StatefulWidget {
  /// Creates a [RegisterForm].
  ///
  /// The optional [onSuccess] callback is called after successful registration.
  const RegisterForm({super.key, this.onSuccess});

  /// Callback invoked after successful registration.
  final VoidCallback? onSuccess;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final loc = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final authApi = context.read<AuthApi>();

    try {
      await authApi.register(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        email: _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
        nickname: _nicknameController.text.trim().isEmpty
            ? null
            : _nicknameController.text.trim(),
      );

      if (mounted) {
        showAppSnackBar(context, loc.registerSuccess);
        widget.onSuccess?.call();
      }
    } catch (e) {
      if (mounted) {
        final msg = e.toString().replaceFirst('Exception: ', '');
        showAppSnackBar(context, msg, isError: true);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showHelp(String title, String content) {
    showDialog<void>(
      context: context,
      builder: (_) => HelpDialog(title: title, content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: '${loc.usernameLabel} *',
                  ),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : loc.usernameInvalid,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: loc.usernameHelpTooltip,
                onPressed: () =>
                    _showHelp(loc.usernameLabel, loc.usernameHelpTooltip),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '${loc.passwordLabel} *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.passwordRequired;
                    } else if (value.length < 8) {
                      return loc.passwordTooShort;
                    }
                    return null;
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: loc.passwordHelpTooltip,
                onPressed: () =>
                    _showHelp(loc.passwordLabel, loc.passwordHelpTooltip),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _nicknameController,
                  decoration: InputDecoration(labelText: loc.nicknameLabel),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: loc.nicknameHelpTooltip,
                onPressed: () =>
                    _showHelp(loc.nicknameLabel, loc.nicknameHelpTooltip),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: loc.emailLabel),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: loc.emailHelpTooltip,
                onPressed: () =>
                    _showHelp(loc.emailLabel, loc.emailHelpTooltip),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isSubmitting ? null : _submit,
            child: Text(_isSubmitting ? loc.registering : loc.registerOption),
          ),
        ],
      ),
    );
  }
}
