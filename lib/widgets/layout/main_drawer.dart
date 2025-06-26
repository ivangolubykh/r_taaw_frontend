import 'package:flutter/material.dart';
import 'package:r_taaw_frontend/core/constants/consts.dart';
import 'package:r_taaw_frontend/l10n/app_localizations.dart';

/// A reusable app drawer with settings and navigation options.
class MainDrawer extends StatelessWidget {
  /// Creates a [MainDrawer].
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Drawer(
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
    );
  }
}
