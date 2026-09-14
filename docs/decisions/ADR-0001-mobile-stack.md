# ADR-0001 — Mobile stack

## Status

Accepted (foundation)

## Context

We are starting a mobile mini-games product that will eventually include a game
catalogue, 2D mini-games, progression, social features, and multiplayer. We
need a clear initial stack decision without integrating every technology on day
one.

## Decision

- **Flutter** is the framework for the mobile application (iOS/Android,
  mobile-first UX shell).
- **Flame** is the planned engine for 2D mini-games.
- **Nakama** is the planned backend for gaming, social, and multiplayer
  concerns.
- **Flutter remains responsible** for the overall application experience
  (navigation shell, menus, profiles UI, non-game screens). Mini-games embed
  into that shell; they do not replace it.

## Consequences

- The monorepo is organized around a Flutter app and Flutter/Dart packages.
- Flame and Nakama are **not integrated in LOT 0.1**. They must not be added
  until a later lot explicitly requires them.
- Shared game concerns will later live under packages such as `game_runtime`;
  that package is a placeholder today.
- Avoid introducing alternate stacks (e.g. a second UI framework or a different
  game engine) without a new ADR.
