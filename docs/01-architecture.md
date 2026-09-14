# Architecture

This document describes **only** what exists after LOT 0.4.

## Repository layout

```text
/
├── apps/
│   └── mobile/                 # Flutter application
├── packages/
│   ├── app_core/               # Environment, config, logging
│   ├── design_system/          # Tokens, theme, UI primitives
│   └── game_runtime/           # Placeholder Flutter package
├── docs/
│   ├── decisions/
│   └── lots/
├── .github/workflows/          # CI quality + Android debug build
├── analysis_options.yaml       # Shared strict analyzer config
├── pubspec.yaml                # Dart Pub workspace root
└── README.md
```

## Workspace

The root `pubspec.yaml` defines a native **Dart Pub workspace**. Member
packages declare `resolution: workspace`. Dependencies between workspace
members are referenced by package name (no Melos).

## Application dependencies

```text
apps/mobile
├── bootstrap/          # AppConfig + error handlers + runApp
├── app/router
├── app/shell
└── features/
       │
       ├── app_core         (environment / config / logging)
       └── design_system    (theme / tokens / primitives)
```

```text
app_core
├── AppEnvironment / AppConfig   (--dart-define=APP_ENV)
└── AppLogger                    (dart:developer)
```

## Application (`apps/mobile`)

Feature-first layout:

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── bootstrap/app_bootstrap.dart
│   ├── router/
│   └── shell/
├── features/
└── shared/presentation/
```

### Navigation

- `MaterialApp.router` + `go_router` + `StatefulShellRoute.indexedStack`
- Routes: `/`, `/games`, `/profile`
- Unknown locations → `NotFoundScreen`

### Theme

- `theme: AppTheme.light` from `design_system`

### Runtime foundation

- Compile-time env via `AppConfig.fromEnvironment()`
- `FlutterError.onError` + `PlatformDispatcher.instance.onError` log then
  present/report (no remote crash reporter)

### What is not present yet

- No auth, networking, persistence, or product catalogue
- No Flame / game runtime logic
- No crash reporting backend
- No native flavors / iOS CI
- No global state management or DI
- No dark theme

## Packages

| Package          | Role today                                                |
|------------------|-----------------------------------------------------------|
| `app_core`       | `AppEnvironment`, `AppConfig`, `AppLogger`                |
| `design_system`  | Semantic tokens, `AppTheme.light`, `AppButton`, `AppCard` |
| `game_runtime`   | Empty placeholder                                         |

## Quality gates

- Format check, analyze (`--fatal-infos --fatal-warnings`), all package tests
- Android debug APK job after quality succeeds
- Flutter **3.41.6** pinned in CI
- See `docs/04-quality-and-environments.md`

---

## Future direction

> **Not implemented.** Directional only.

**Flutter (app shell & UX)** → **Flame (2D mini-games)** → **Nakama (backend /
social / multiplayer)**.
