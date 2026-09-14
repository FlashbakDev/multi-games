# ADR-0004 — Quality and runtime foundation

## Status

Accepted

## Context

After LOT 0.1–0.3 the monorepo builds and tests locally, but CI used an
unpinned Flutter channel, analyze was not fatal on infos/warnings, there was
no Android build gate, and the app lacked a shared environment / logging /
error-handling foundation before Game Runtime work begins.

## Decision

- Pin CI to **Flutter 3.41.6** (matching the validated local SDK).
- Quality gates: **format** (check-only), **analyze** with
  `--fatal-infos --fatal-warnings`, **all package tests**, then **Android
  debug APK** in a dependent job.
- Select environments at compile time via `--dart-define=APP_ENV=…` with a
  typed `AppEnvironment` / `AppConfig` in `app_core` (default: development;
  invalid values throw).
- Log through a thin `AppLogger` over **`dart:developer`** (no third-party
  logger).
- Capture unhandled Flutter / platform errors in bootstrap (log + present /
  report; no swallowing; no remote reporter).
- No global coverage threshold; no native Android/iOS flavors yet; no iOS CI
  runner yet.
- Dependabot weekly for Pub (workspace members) and GitHub Actions.
- No new external runtime dependencies for this foundation.

## Consequences

### Positive

- Local and CI toolchains stay aligned.
- Misconfigured `APP_ENV` fails loudly instead of becoming production.
- Errors are visible in logs without pretending we have Crashlytics/Sentry.
- Android regressions are caught before merge when quality passes.

### Negative

- Android CI job adds wall-clock time (mitigated by `needs: quality`).
- dart-define is not a secret store — team must stay disciplined.
- iOS compile breaks are not detected in CI yet.
- Dependabot Pub with workspaces may open multiple related PRs.

## Alternatives considered

- **Unpinned `channel: stable`** — drifts from local validated SDK.
- **dotenv / flavor files for env** — heavier; deferred until needed.
- **Sentry/Firebase Crashlytics now** — product/backend decision not ready.
- **`runZonedGuarded` by default** — risk of double-handling vs current
  Flutter APIs; omitted unless proven necessary.
- **Global coverage threshold** — premature metric for this stage.
