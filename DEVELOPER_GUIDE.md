# 👩‍💻 Developer Guide — R-Taaw Frontend

Welcome! This document will help you get started as a contributor to the **R-Taaw** frontend.  
We follow a clear and consistent contribution workflow based on issues, branches, and pull requests.

---

## 🚀 Project Overview

The frontend is written in **Flutter** and supports:

- Localization via `.arb` files
- Theme switching (light/dark) using a `ThemeProvider`
- Clean routing structure via `go_router`
- Target platforms: **Android** and **Web**

---

## ⚙️ Environment Setup

- Configuration values are stored in `.env` (copied from `.env.example`)
- Use `flutter_dotenv` to access env variables in code
- For multi-platform builds, use the Makefile target:
  ```bash
  make build-all
  ```

---

## 🧭 Where to Start

1. **Clone the repo**
   ```bash
   git clone https://github.com/ivangolubykh/r_taaw_frontend.git
   cd r_taaw_frontend
   flutter pub get
   ```
2. **Run the project**
   ```bash
   flutter run -d chrome  # or any supported device
   ```

---

## 🛠️ Development Workflow

We use a `Makefile` to standardize project tasks. Available commands:

- `make format` – Auto-format code and sort imports
- `make fix` – Apply Dart automatic fixes
- `make lint` – Run static analysis (`flutter analyze`)
- `make check` – Run fix, format, and lint in sequence
- `make test` – Run all unit/widget tests
- `make test-cov` – Run tests and collect coverage
- `make coverage` – Generate HTML coverage report (requires `lcov`)
- `make run` – Run the app
- `make build-all` – Build for all platforms using `.env`

---

## 📂 Contribution Workflow

**🔖 Step 1: Find or Create an Issue**

All work should be tracked via GitHub Issues. Before starting:
- Check if an issue already exists.
- If not, create a new one with a clear title and description.

**🌿 Step 2: Create a Branch**

Always fork the repository if you're not a maintainer.
- Base your branch on the latest dev branch.
- Use this naming pattern:
    ```text
    issue-<issue_number>-<short-description>
    ```
  Example:
    ```text
    issue-14-add-theme-toggle
    ```

**📦 Step 3: Commit Guidelines**

- Use clear, meaningful commit messages.
- Reference the issue in your commits using `[#<issue_number>]`.

  Example:
    ```text
    [#14] Add light/dark theme toggle
    ```

**📬 Step 4: Open a Pull Request**

- Target `dev`, not `main`.
- Name your PR like this:
    ```text
    [#14] Add light/dark theme toggle
    ```
- In the PR description:
  - Describe what was added or changed.
  - Mention which issue it closes with: `Closes #14`

---

## 📚 Localization

- Locales are managed in `lib/l10n/` via `.arb` files.
- Use [Flutter Intl](https://docs.flutter.dev/development/accessibility-and-localization/internationalization) conventions.
- Supported locales come from the backend.
- To add new translations:
  1. Edit the appropriate `.arb` files.
  2. Run:
     ```bash
     make gen-l10n
     ```

---

## 🎨 Theming

- Theme toggling is implemented via a custom `ThemeProvider`.
- `ThemeMode.system` is the default.
- Users can toggle light/dark mode from any screen.
- Themes are configured in `main.dart`.

---

## 🧭 Routing

- We use `go_router` for navigation.
- All routes are defined in `lib/routing/router.dart`.
- Route paths should be clear and semantic:
  ```text
  /login
  /register
  /recipes/:id
  ```

---

## 🔍 Folder Structure

```text
lib/
├── main.dart
├── l10n/                  # Localization files
├── theme/                 # Theme provider
├── routing/               # go_router config
├── core/                  # Storage, constants, helpers
├── services/              # User settings, auth
└── screens/               # UI pages (to be expanded)
```

---

## 📎 Notes

- The `main` branch is reserved for stable, production-ready code.
- The `dev` branch is the mainline for ongoing development.
- Delete feature branches after merging — safe and encouraged.
- Code reviews are required before merging any PR.

---

## 🙏 Thanks!

We appreciate your help making R-Taaw better.

For questions, open an issue or contact [Ivan Golubykh](https://github.com/ivangolubykh).
