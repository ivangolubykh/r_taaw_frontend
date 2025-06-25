#!/bin/bash
set -e

# Determine absolute path to the root of the project
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

# Load .env variables
if [ -f .env ]; then
  set -o allexport
  source .env
  set +o allexport
else
  echo "❌ .env file not found!"
  exit 1
fi

# Required dart-defines
DART_DEFINES="--dart-define=API_BASE_URL=${API_BASE_URL}"

echo "▶️ Building Flutter Web..."
flutter build web $DART_DEFINES

echo "📦 Building Flutter Android APK..."
flutter build apk $DART_DEFINES

echo -e "\n    \033[1;32m✅ All builds completed successfully.\033[0m\n"
