import 'package:flutter/material.dart';

/// A dialog widget that shows a scrollable help message.
///
/// The dialog displays a [title] and [content] with scrolling support
/// to accommodate longer texts. It has a single "OK" button to dismiss.
class HelpDialog extends StatelessWidget {
  /// Creates a [HelpDialog] with the given [title] and [content].
  ///
  /// Both [title] and [content] are required and must not be null.
  const HelpDialog({required this.title, required this.content, super.key});

  /// The title text displayed at the top of the dialog.
  final String title;

  /// The content text displayed in the scrollable area of the dialog.
  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(title),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300, minWidth: 300),
        child: SingleChildScrollView(
          child: Text(content, style: theme.textTheme.bodyMedium),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
