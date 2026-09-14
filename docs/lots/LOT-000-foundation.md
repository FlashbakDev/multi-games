# LOT 000 — Foundation

## Status

In progress (sub-lots 0.1–0.4 complete)

## Goal

Establish a stable, reproducible, documented Flutter monorepo foundation that
can later host multiple packages and mini-games — without implementing product
features yet.

## Scope

- Monorepo layout (`apps/`, `packages/`, `docs/`, CI)
- Runnable Flutter mobile app with declarative navigation shell
- Shared design system package (tokens, theme, primitives)
- Runtime foundation: environments, logging, error handlers
- Hardened CI quality gates (format / analyze / test / Android debug)
- Strict static analysis
- Initial documentation and ADRs

## Out of scope

- Mini-game catalogue and any game content
- Flame / Rive
- Nakama / Firebase / databases
- Onboarding, real profiles, social, multiplayer
- State management / networking libraries
- Store deployment
- Dark mode, brand fonts, large component catalog

## Sub-lots

### LOT 0.1 — Bootstrap

Status: DONE

#### Implemented

- Dart Pub workspace at repository root
- Flutter app `apps/mobile` with Material 3 foundation screen
  (`mobile`, `Foundation ready`, version, platform, workspace packages)
- Placeholder packages: `app_core`, `design_system`, `game_runtime`
- Root `.gitignore`, shared `analysis_options.yaml`, root `README.md`
- GitHub Actions workflow (format, analyze, test)
- Docs: principles, architecture, workflow, ADR-0001, this lot file

#### Architecture decisions

- Native Pub workspaces (no Melos)
- No business architecture inside packages yet
- No Flame / Nakama / Firebase / DB in this sub-lot
- See `docs/decisions/ADR-0001-mobile-stack.md`

#### Tests

- `apps/mobile`: app builds; widget test for `Foundation ready`
- Each package: smoke test that the library loads

#### Validation

Commands executed successfully from the repository root:

```bash
dart format .
flutter analyze
flutter test apps/mobile
flutter test packages/app_core
flutter test packages/design_system
flutter test packages/game_runtime
```

Also verified locally:

- `dart format --set-exit-if-changed .` → clean
- `flutter analyze` → No issues found
- All listed tests → passed
- `flutter build apk --debug` (from `apps/mobile`) → success

#### Known limitations

- Packages are empty placeholders (no real APIs)
- App has no navigation or product UX
- Version shown on screen is a const mirrored from `pubspec.yaml` (no
  `package_info` dependency)
- Web platform files exist from `flutter create` but are not a product target

### LOT 0.2 — Application architecture and navigation

Status: DONE

#### Implemented

- Feature-first `lib/` layout (`app/`, `features/`, `shared/`)
- Minimal `main.dart` → `App` with `MaterialApp.router`
- `go_router` with `StatefulShellRoute.indexedStack` (Accueil / Jeux / Profil)
- `AppShell` with Material 3 `NavigationBar`
- Centralized `AppRoutes`
- `NotFoundScreen` for unknown locations
- Placeholder feature screens (labels only)

#### Dependencies

- `go_router: ^17.5.0` (resolved `17.5.0`) — latest stable compatible with
  Flutter 3.41.6 / Dart 3.11.4 (`18.x` not selected by pub solver)

#### Architecture decisions

- Declarative navigation; no custom NavigationService
- Shell owns the main `Scaffold`; feature screens are body-only
- No global state management / DI
- See `docs/decisions/ADR-0002-navigation.md`

#### Tests

- Startup: Accueil + NavigationBar destinations
- Tab navigation: Jeux, Profil, return Accueil
- Unknown route → Page introuvable → Retour à l'accueil
- Branch state preservation (`HomeScreen` State identity)
- `AppRoutes` path constants

#### Validation

```bash
dart format .
flutter analyze
flutter test apps/mobile packages/app_core packages/design_system packages/game_runtime
flutter build apk --debug   # from apps/mobile
```

#### Known limitations

- Screens are placeholders (no product content)
- No deep-link / auth redirect configuration yet
- `design_system` and `game_runtime` still empty
- No design tokens (LOT 0.3)

### LOT 0.3 — Design system foundation

Status: DONE

#### Implemented

- `packages/design_system` with public barrel export
- Semantic `AppColors` ThemeExtension + Material `ColorScheme`
- `AppTypography`, `AppSpacing`, `AppRadius`, `AppMotion`
- `AppTheme.light` (Material 3 component themes including NavigationBar)
- Primitives: `AppButton`, `AppCard`
- Mobile app uses `theme: AppTheme.light`
- Placeholder screens use spacing + typography tokens
- `NotFoundScreen` uses `AppButton`

#### Design tokens

- Colors: primary, surfaces, text, border, success/warning/danger, disabled,
  pressed/subtle brand
- Type: display / title / body / label (system fonts)
- Spacing: 4–48 scale
- Radius: 8–24 + pill
- Motion: 120 / 220 / 360 ms

#### Components

- `AppButton` (primary, secondary, danger, loading, icon, expanded)
- `AppCard` (surface, border, radius, padding)

#### Architecture decisions

- Internal design system on Material 3; no external UI kit
- Semantic tokens over shade ladders
- Dark theme deferred but structure-ready
- See `docs/decisions/ADR-0003-design-system.md`

#### Tests

- Theme construction + key values
- `AppButton`: tap, disabled, loading, icon, text scale 1.5
- `AppCard`: child, padding, surface styling
- Mobile: navigation suite + uses `AppTheme.light`

#### Validation

```bash
dart format .
flutter analyze
flutter test apps/mobile packages/app_core packages/design_system packages/game_runtime
flutter build apk --debug   # from apps/mobile
```

#### Known limitations

- No dark theme
- System fonts only
- Only two primitives (`AppButton`, `AppCard`)
- No product Home / catalogue UI
- No custom press-scale animations

### LOT 0.4 — Quality gates and CI hardening

Status: DONE

#### Implemented

- `app_core`: `AppEnvironment`, `AppConfig`, `AppLogger`
- Mobile `bootstrapApplication` + error handlers
- CI: pinned Flutter 3.41.6, fatal infos/warnings, format check-only,
  all package tests, Android debug job after quality
- Dependabot (weekly Pub + GitHub Actions)
- Docs: quality/environments guide + ADR-0004

#### Environment strategy

- `APP_ENV`: `development` | `staging` | `production`
- Default when omitted: `development`
- Invalid/empty: `ArgumentError` (never silent production)

#### Logging and error handling

- `AppLogger` → `dart:developer` (debug skipped in release)
- `FlutterError.onError` → log + `presentError`
- `PlatformDispatcher.onError` → log, return `false`
- No remote crash reporting

#### CI gates

1. `quality` — format, analyze, tests
2. `android-build` — needs quality; `flutter build apk --debug`
- concurrency cancel-in-progress; `contents: read`; timeouts set
- No iOS CI yet

#### Architecture decisions

- Compile-time env via dart-define (not a secret store)
- No third-party logger / crash reporter
- No coverage threshold
- See `docs/decisions/ADR-0004-quality-runtime-foundation.md`

#### Tests

- `AppEnvironment.parse` + invalid/empty
- `AppConfig.fromEnvironment` default / inject / invalid
- Bootstrap: config available; handlers do not break widget tests
- Existing navigation + design_system suites unchanged

#### Validation

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze --fatal-infos --fatal-warnings
flutter test apps/mobile
flutter test packages/app_core
flutter test packages/design_system
flutter test packages/game_runtime
flutter build apk --debug   # from apps/mobile
flutter pub deps
```

#### Known limitations

- No iOS CI / macOS runner
- No crash reporter backend
- No native product flavors
- Dependabot may open multiple Pub PRs in a workspace
- GitHub Actions remote run not executed from this environment

## Next sub-lot

LOT 0.5 — Game Runtime contract
