# Multi Games

Monorepo for a mobile-first mini-games application (Flutter).

Foundation only: navigation shell, design system, app_core runtime primitives,
CI quality gates. Product features are not implemented yet.

## Structure

```text
apps/mobile              Flutter application
packages/app_core        Environment, config, logging
packages/design_system   Tokens, theme, UI primitives
packages/game_runtime    Game runtime (placeholder)
docs/                    Project documentation
```

## Prerequisites

- Flutter **3.41.6** / Dart 3.11+ (matches CI)
- Android Studio / Xcode for device builds

## Essential commands

```bash
# From repository root
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze --fatal-infos --fatal-warnings
flutter test apps/mobile packages/app_core packages/design_system packages/game_runtime
```

```bash
cd apps/mobile
flutter run --dart-define=APP_ENV=development
flutter build apk --debug
```

## Documentation

See [`docs/`](docs/) — especially [`docs/04-quality-and-environments.md`](docs/04-quality-and-environments.md).
