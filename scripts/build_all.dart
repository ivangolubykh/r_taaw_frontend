#!/usr/bin/env dart

import 'dart:io';

/// ANSI escape codes for colored terminal output
const red = '\x1B[31m';
const green = '\x1B[32m';
const bold = '\x1B[1m';
const reset = '\x1B[0m';

Future<void> main() async {
  // Determine absolute project root
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final projectRoot = scriptDir.parent;
  Directory.current = projectRoot;

  final envFile = File('.env');
  if (!envFile.existsSync()) {
    logError('.env file not found!');
    exit(1);
  }

  final envVars = loadEnv(envFile);
  final apiBaseUrl = envVars['API_BASE_URL'];
  if (apiBaseUrl == null) {
    logError('API_BASE_URL not set in .env');
    exit(1);
  }

  final dartDefines = '--dart-define=API_BASE_URL=$apiBaseUrl';

  try {
    stdout.writeln('▶️  Building Flutter Web...');
    await runCommand('flutter', ['build', 'web', dartDefines]);

    stdout.writeln('📦 Building Flutter Android APK...');
    await runCommand('flutter', ['build', 'apk', dartDefines]);

    logSuccess('All builds completed successfully.');
  } catch (e) {
    logError('Build failed: $e');
    exit(1);
  }
}

Map<String, String> loadEnv(File file) {
  final lines = file.readAsLinesSync();
  final env = <String, String>{};
  for (var line in lines) {
    line = line.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    final index = line.indexOf('=');
    if (index != -1) {
      final key = line.substring(0, index).trim();
      final value = line.substring(index + 1).trim();
      env[key] = value;
    }
  }
  return env;
}

Future<void> runCommand(String executable, List<String> args) async {
  final result = await Process.start(executable, args);
  await stdout.addStream(result.stdout);
  await stderr.addStream(result.stderr);
  final exitCode = await result.exitCode;
  if (exitCode != 0) {
    throw Exception('$executable ${args.join(' ')} failed with code $exitCode');
  }
}

void logSuccess(String message) {
  stdout.writeln('\n  $bold$green✅ $message$reset\n');
}

void logError(String message) {
  stderr.writeln('$red❌ $message$reset');
}
