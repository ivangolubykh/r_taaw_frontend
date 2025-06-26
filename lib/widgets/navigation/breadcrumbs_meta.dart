import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:r_taaw_frontend/widgets/navigation/breadcrumbs_bar.dart';

/// Metadata used to define breadcrumb information for a route.
///
/// You can associate a route with a [BreadcrumbMeta] using
/// [GoRouteBreadcrumbExtension.withBreadcrumb].
class BreadcrumbMeta {
  /// Creates a breadcrumb metadata object.
  const BreadcrumbMeta({required this.labelBuilder, this.parentName});

  /// Shortcut for creating static breadcrumbs with optional [parentName].
  ///
  /// Example:
  /// ```dart
  /// BreadcrumbMeta.static(
  ///   label: (context) => AppLocalizations.of(context)!.breadcrumbHome,
  /// );
  /// ```
  factory BreadcrumbMeta.static({
    required String Function(BuildContext context) label,
    String? parentName,
  }) {
    return BreadcrumbMeta(
      parentName: parentName,
      labelBuilder: (context, _) => label(context),
    );
  }

  /// Optional name of the parent route to build the breadcrumb hierarchy.
  final String? parentName;

  /// Function that returns a localized label for the breadcrumb.
  final String Function(BuildContext context, GoRouterState state) labelBuilder;
}

/// Internal registry for associating route names with [BreadcrumbMeta].
final Map<String, BreadcrumbMeta> _breadcrumbRegistry = {};

/// Extension method on [GoRoute] to attach [BreadcrumbMeta] via a fluent API.
extension GoRouteBreadcrumbExtension on GoRoute {
  /// Registers this [GoRoute] with its associated [BreadcrumbMeta].
  ///
  /// Must only be called on routes with a non-null [name].
  GoRoute withBreadcrumb(BreadcrumbMeta meta) {
    if (name != null) {
      _breadcrumbRegistry[name!] = meta;
    }
    return this;
  }
}

/// Resolves a list of [BreadcrumbItem]s based on the current [GoRouterState].
///
/// Uses the [_breadcrumbRegistry] to walk the parent chain and generate
/// breadcrumbs from the deepest route to the top-level root.
List<BreadcrumbItem> resolveBreadcrumbsFromState(
  BuildContext context,
  GoRouterState state,
) {
  final crumbs = <BreadcrumbItem>[];
  var currentName = state.name;
  final currentState = state;

  while (currentName != null) {
    final meta = _breadcrumbRegistry[currentName];
    if (meta == null) break;

    final isLast = crumbs.isEmpty;
    final label = meta.labelBuilder(context, currentState);
    final path = isLast ? null : state.namedLocation(currentName);

    crumbs.insert(0, BreadcrumbItem(label: label, path: path));
    currentName = meta.parentName;
  }

  return crumbs;
}
