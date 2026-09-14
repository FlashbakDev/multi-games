# Quality and environments

## Local quality checks

Reproduce CI gates from the repository root:

```bash
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze --fatal-infos --fatal-warnings
flutter test apps/mobile
flutter test packages/app_core
flutter test packages/design_system
flutter test packages/game_runtime
```

Android debug build (from `apps/mobile`):

```bash
cd apps/mobile
flutter build apk --debug
```

## CI gates

GitHub Actions (`.github/workflows/ci.yml`) blocks a PR when any of these fail:

1. **quality** job
   - `dart format --output=none --set-exit-if-changed .`
   - `flutter analyze --fatal-infos --fatal-warnings`
   - tests for `apps/mobile` and all packages
2. **android-build** job (runs only if **quality** succeeds)
   - `flutter build apk --debug` in `apps/mobile`

CI uses Flutter **3.41.6** (pinned). No store upload, no APK publishing.

iOS builds are **not** run in CI yet (no macOS runner on every commit).

## Environments

Supported `APP_ENV` values:

| Value | Meaning |
|-------|---------|
| `development` | Local / default when define is omitted |
| `staging` | Pre-production |
| `production` | Production |

Unknown or empty values throw at config construction — they never silently
become `production`.

## Running with an environment

```bash
cd apps/mobile
flutter run --dart-define=APP_ENV=development
flutter run --dart-define=APP_ENV=staging
flutter run --dart-define=APP_ENV=production
```

## Secrets

Values passed via `--dart-define` can be present in the compiled binary and
**must never be treated as secrets**.

Safe later examples: `APP_ENV`, public API base URLs, public feature config.

Never via dart-define: private keys, DB passwords, server secrets, payment
secrets, admin credentials.

## Logging

`AppLogger` (`packages/app_core`) wraps `dart:developer`:

| Level | Use |
|-------|-----|
| `debug` | Developer diagnostics (skipped in release) |
| `info` | Expected technical events |
| `warning` | Recoverable anomalies |
| `error` | Real failures (`error` + `stackTrace` when available) |

Never log passwords, auth/refresh tokens, payment data, secrets, or full user
payloads without a clear need. No automatic redaction yet — convention only.

Do not use `print()` in application code.

## Error handling

On bootstrap:

- `FlutterError.onError` → `AppLogger.error` then `FlutterError.presentError`
- `PlatformDispatcher.instance.onError` → `AppLogger.error`, returns `false`
  so the engine still reports the error

No product crash UI yet. No remote crash reporter yet.

## Crash reporting

Not implemented yet.

## Coverage policy

No global coverage threshold (80%/90%/100%) for now.

Rule: **each significant behavior added must be tested.** Targeted thresholds
may come later with domain / game-runtime code.
