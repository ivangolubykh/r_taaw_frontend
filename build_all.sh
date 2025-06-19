#!/usr/bin/env bash

# Load .env variables
if [ -f .env ]; then
  set -o allexport
  source .env
  set +o allexport
else
  echo ".env file not found!"
  exit 1
fi

# Required dart-defines
DART_DEFINES="--dart-define=API_BASE_URL=${API_BASE_URL}"

# Web build
echo "▶️ Building Flutter Web..."
flutter build web $DART_DEFINES || exit 1

# Android build (APK)
echo "📦 Building Flutter Android APK..."
flutter build apk $DART_DEFINES || exit 1

echo -e "\n    \033[1;32m✅ All builds completed successfully.\033[0m\n"
