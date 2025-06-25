#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';

/// ANSI colors for terminal output
const String green = '\x1B[1;32m';
const String red = '\x1B[1;31m';
const String reset = '\x1B[0m';

Future<void> main(List<String> args) async {
  // Determine absolute project root
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final projectRoot = scriptDir.parent;
  Directory.current = projectRoot;
  final l10nDir = Directory('${projectRoot.path}/lib/l10n');

  if (!l10nDir.existsSync()) {
    stderr.writeln('$red❌ Directory lib/l10n not found.$reset');
    exit(1);
  }

  final arbFiles = l10nDir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.arb'))
      .toList();

  if (arbFiles.isEmpty) {
    stderr.writeln('$red❌ No .arb files found in lib/l10n.$reset');
    exit(1);
  }

  for (final file in arbFiles) {
    try {
      final content = await file.readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;

      final keys = json.keys.where((k) => !k.startsWith('@')).toList()..sort();
      final meta = json.keys.where((k) => k.startsWith('@')).toList()..sort();

      final sortedMap = <String, dynamic>{};

      for (final key in keys) {
        sortedMap[key] = json[key];
        final metaKey = '@$key';
        if (json.containsKey(metaKey)) {
          sortedMap[metaKey] = json[metaKey];
          meta.remove(metaKey);
        }
      }

      // Add remaining orphaned metadata
      for (final metaKey in meta) {
        sortedMap[metaKey] = json[metaKey];
      }

      const encoder = JsonEncoder.withIndent('  ');
      await file.writeAsString('${encoder.convert(sortedMap)}\n');
      stdout.writeln('$green✔ Sorted ${file.path}$reset');
    } catch (e) {
      stderr.writeln('$red❌ Failed to sort ${file.path}: $e$reset');
    }
  }

  stdout.writeln('\n$green✅ All .arb files sorted.$reset\n');
}
