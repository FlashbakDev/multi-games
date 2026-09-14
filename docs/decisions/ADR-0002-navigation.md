# ADR-0002 — Application navigation

## Status

Accepted

## Context

LOT 0.1 delivered a runnable Flutter monorepo with a single smoke screen and
no navigation. The product will need multiple top-level destinations (home,
games catalogue, profile) and, later, deep links into specific screens or
games sessions. We need a navigation foundation that is declarative, testable,
and compatible with a bottom navigation shell — without introducing global
state management or a custom navigation abstraction layer yet.

## Decision

- Use **`go_router`** for declarative, URL-based navigation on top of
  Flutter’s Router / Navigator 2 APIs.
- Configure the app with **`MaterialApp.router`** and a **single `GoRouter`
  instance** owned by the root `App` widget (not recreated on every build).
- Use **`StatefulShellRoute.indexedStack`** for the three primary
  destinations so each tab keeps its own navigation branch and in-memory UI
  state when switching tabs.
- Drive tab changes with **`StatefulNavigationShell.goBranch`**, including
  `initialLocation: true` when re-tapping the active tab.
- Centralize path strings in **`AppRoutes`** (no scattered magic strings).
- Handle unknown locations with **`errorBuilder`** → a minimal
  `NotFoundScreen`.
- **Do not** introduce Riverpod/Bloc/Provider, GetIt, or a homemade
  `NavigationService` / use-case layer for routing.

## Consequences

### Positive

- Clear, declarative route map that can later support deep linking.
- Tab state preservation without a parallel index-management system.
- Screens stay free of low-level Navigator stack manipulation.
- Easy to widget-test destinations and unknown routes via
  `initialLocation`.

### Negative

- Adds one direct dependency (`go_router`) and its transitive packages
  (`logging`, `flutter_web_plugins`).
- Team must learn `go_router` shell/branch APIs.
- Deep linking / auth redirects are not configured yet and will need careful
  follow-up when those features arrive.

## Alternatives considered

- **Imperative `Navigator` + manual `BottomNavigationBar` index** — works for
  a tiny app but fights deep linking and multi-stack tabs.
- **`auto_route` / code generation** — more machinery than we need at this
  stage.
- **Custom `NavigationService` / repository** — unnecessary indirection while
  screens can use `go_router` extensions directly when required.
