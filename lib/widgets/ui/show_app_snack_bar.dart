import 'package:flutter/material.dart';

/// Shows a themed floating SnackBar with optional error styling.
void showAppSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  final backgroundColor = isError
      ? (isDark ? Colors.red.shade300 : Colors.red.shade100)
      : (isDark ? Colors.green.shade400 : Colors.green.shade100);

  final textColor = isError
      ? (isDark ? Colors.black : Colors.red.shade900)
      : (isDark ? Colors.black : Colors.green.shade900);

  final snackBar = SnackBar(
    content: Text(message, style: TextStyle(color: textColor)),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
