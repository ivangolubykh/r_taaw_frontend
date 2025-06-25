import 'package:flutter/material.dart';

/// An [InheritedWidget] that provides theme-related state and actions
/// throughout the widget tree.
///
/// Use [ThemeProvider.of] to access the current [ThemeMode] and the
/// [toggleTheme] callback.
class ThemeProvider extends InheritedWidget {
  /// Creates a [ThemeProvider].
  const ThemeProvider({
    required this.themeMode,
    required this.toggleTheme,
    required super.child,
    super.key,
  });

  /// The current theme mode (light, dark, or system).
  final ThemeMode themeMode;

  /// Callback to toggle between light and dark theme modes.
  final VoidCallback toggleTheme;

  /// Retrieves the nearest [ThemeProvider] up the widget tree.
  static ThemeProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(result != null, 'No ThemeProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
