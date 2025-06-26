import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Represents a single breadcrumb item used in [BreadcrumbsBar].
///
/// If [path] is `null`, the item is considered
/// the current (unclickable) location.
class BreadcrumbItem {
  /// Creates a breadcrumb item.
  const BreadcrumbItem({required this.label, this.path});

  /// Text label to display in the breadcrumb.
  final String label;

  /// Optional path used for navigation when the item is clickable.
  final String? path;
}

/// A horizontal list of clickable breadcrumbs displayed under an AppBar.
///
/// The last item is shown as plain bold text to indicate the current page.
class BreadcrumbsBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [BreadcrumbsBar] with a list of [BreadcrumbItem]s.
  const BreadcrumbsBar({required this.items, super.key});

  /// List of breadcrumb items to display in order.
  final List<BreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0) Text('›', style: theme.textTheme.bodyMedium),
            if (items[i].path != null && i != items.length - 1)
              GestureDetector(
                onTap: () => context.go(items[i].path!),
                child: Text(
                  items[i].label,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            else
              Text(
                items[i].label,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ],
      ),
    );
  }

  /// Preferred height for the breadcrumb bar below the AppBar.
  @override
  Size get preferredSize => const Size.fromHeight(40);
}
