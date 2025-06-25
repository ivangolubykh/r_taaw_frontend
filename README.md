# R‑Taaw: Recipes to Remember — Frontend

**R‑Taaw** is an open recipe book where users can store, manage, and optionally share their favorite recipes.  
This repository contains the **Flutter-based frontend** of the project.

> ⚠️ **Naming Note**: The project name **R-Taaw** and its variants (**D-Taaw**, **C-Taaw**, etc.) are unique identifiers created by **Ivan Golubykh**. Do not use these names in derivative projects or registered trademarks without permission.

> 🧭 The backend is available at: [r_taaw_backend](https://github.com/ivangolubykh/r_taaw_backend)

---

## 📱 Tech Stack

- **Flutter 3.32.4** (stable)
- **Dart 3.8.1**
- **Navigation**: `go_router`
- **State**: custom `ThemeProvider` via `InheritedWidget`
- **Localization**: `.arb` files, `flutter_localizations`
- **Linting**: [`very_good_analysis`](https://pub.dev/packages/very_good_analysis)
- **Supported platforms**: Android, Web

---

## 🚀 Getting Started

### ✅ Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart ≥ 3.8
- Git

### 🛠 Installation

```bash
git clone https://github.com/ivangolubykh/r_taaw_frontend.git
cd r_taaw_frontend
cp .env.example .env
make pub-get
make run
```

To run on web:

```bash
flutter run -d chrome
```

---

## 🧱 Project Structure (in progress)

```bash
lib/
├── main.dart              # App entry point
├── routing/               # go_router config
│   └── router.dart
├── theme/                 # Theme provider
│   └── theme_provider.dart
├── l10n/                  # Localization support
└── screens/               # Will contain UI screens

scripts/
├── build_all.dart         # Build app for all platforms (replaces old shell script)
└── sort_arb.dart          # Sort .arb localization files by key order
```

---

## 🧑‍💻 Development

- Light/dark theme switching is supported via a central ThemeProvider.
- Localization is already wired; use `.arb` files in `lib/l10n/` to add translations.
- Routing is handled via `go_router`. Main route: `/`.
- Language and theme controls will be accessible from any screen (planned).

### ⚙️ Environment and Builds

- Environment variables are stored in `.env` (see `.env.example`)
- To build for all supported platforms at once, run:

```bash
make build-all
```

---

## 🛠 Makefile Commands

Common tasks are available via `make`:

| Command             | Description                                              |
|--------------------|----------------------------------------------------------|
| `make format`       | Sort imports and format code                            |
| `make fix`          | Apply Dart auto-fixes                                   |
| `make lint`         | Run analyzer and check for lints                        |
| `make check`        | Run fix, format, and lint in sequence                   |
| `make test`         | Run all tests                                           |
| `make test-cov`     | Run tests and collect coverage                          |
| `make coverage`     | Generate HTML coverage report via `genhtml`            |
| `make run`          | Launch the app                                          |
| `make build-all`    | Build app for all supported platforms (Dart script)     |
| `make sort-arb`     | Sort all `.arb` localization files by key and metadata  |
| `make clean`        | Clean build artifacts                                   |
| `make pub-get`      | Install dependencies                                    |
| `make pub-upgrade`  | Upgrade dependencies                                    |
| `make gen-l10n`     | Generate localization files from `.arb`                 |

> Local overrides can be defined in `Makefile.local`.

---

## 📅 Linting & Code Style

This project uses [`very_good_analysis`](https://pub.dev/packages/very_good_analysis) for enforcing strict and consistent Dart style.

- All code must follow the linter rules defined in `analysis_options.yaml`.
- Documentation for public classes/functions is required (can be added incrementally).
- Run `make check` before submitting a PR.

---

## 📄 Additional Materials

- [`LICENSE`](LICENSE) — project license (MIT)
- [`DEVELOPER_GUIDE.md`](DEVELOPER_GUIDE.md) — contributor instructions

---

## 🖼 Screenshots (planned)

> App screenshots will be added once UI development progresses.

---

## 🌐 Project Homepage (planned)

[https://r-taaw.allworld.xyz](https://r-taaw.allworld.xyz)
