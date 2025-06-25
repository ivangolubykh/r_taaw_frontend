.PHONY: help format fix lint check run build-all clean pub-get pub-upgrade gen-l10n test test-cov coverage sort-arb

-include Makefile.local

help:
	@echo "Available commands:"
	@echo "  make format            - Sort imports and format Dart code"
	@echo "  make fix               - Apply automatic Dart fixes"
	@echo "  make lint              - Analyze the project for errors and lints"
	@echo "  make check             - Run fix, format, and lint in sequence"
	@echo "  make test              - Run tests only"
	@echo "  make test-cov          - Run tests and collect coverage"
	@echo "  make coverage          - Generate HTML coverage report (requires lcov)"
	@echo "  make run               - Run the app"
	@echo "  make build-all         - Build app for all supported platforms (uses Dart script)"
	@echo "  make clean             - Clean build artifacts"
	@echo "  make pub-get           - Get dependencies"
	@echo "  make pub-upgrade       - Upgrade dependencies"
	@echo "  make gen-l10n          - Generate localization files"
	@echo "  make sort-arb          - Alphabetically sort all .arb localization files"

format:
	dart fix --apply
	dart format .

fix:
	dart fix --apply

lint:
	flutter analyze

check: fix format lint

test:
	flutter test

test-cov:
	flutter test --coverage

coverage:
	genhtml coverage/lcov.info -o coverage/html

run:
	flutter run

build-all:
	dart scripts/build_all.dart

clean:
	flutter clean

pub-get:
	flutter pub get

pub-upgrade:
	flutter pub upgrade

gen-l10n:
	flutter gen-l10n

sort-arb:
	dart scripts/sort_arb.dart
