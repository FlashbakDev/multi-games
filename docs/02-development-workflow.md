# Development workflow

## Install

1. Install [Flutter](https://docs.flutter.dev/get-started/install) **3.41.6**
   (matches CI).
2. Clone this repository.
3. From the repository root:

```bash
flutter doctor
flutter --version   # expect 3.41.6
```

## Get dependencies

```bash
flutter pub get
```

## Run the application

```bash
cd apps/mobile
flutter run --dart-define=APP_ENV=development
```

Other environments: `staging`, `production`.

## Local CI parity (quality gates)

Run from the repository root before opening a PR:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze --fatal-infos --fatal-warnings
flutter test apps/mobile
flutter test packages/app_core
flutter test packages/design_system
flutter test packages/game_runtime
```

Android debug build:

```bash
cd apps/mobile
flutter build apk --debug
```

Details: [`docs/04-quality-and-environments.md`](04-quality-and-environments.md).

## Format (rewrite files)

```bash
dart format .
```

## Contribution basics

- Keep changes incremental and scoped to the active lot.
- Do not add dependencies without a concrete need in the same change.
- Do not implement future product features ahead of their lot.
- Do not use `print()` — use `AppLogger`.
- Never put secrets in `--dart-define`.
- Update the relevant lot document and ADR when making structural decisions.
- Ensure the local CI-parity commands above pass before PR.
