# Project principles

Initial technical principles for the multi-games mobile application.

## Mobile-first

The product targets iOS and Android as primary platforms. UX, performance, and
layout decisions prioritize phones. Other platforms may exist for development
convenience but are not product goals at this stage.

## Fluidity first

Interactions should feel immediate. Prefer simple widget trees, predictable
rebuilds, and careful asset/loading strategies. Avoid work on the UI isolate
that can cause jank.

## Modular architecture

The repository is a monorepo. Application code, shared utilities, design
system, and game runtime live in separate packages so boundaries stay clear and
ownership stays explicit.

## Isolated mini-games

Each mini-game should be as isolated as possible from the rest of the app and
from other games. Shared runtime concerns belong in dedicated packages; game
rules and assets should not leak into the shell application unnecessarily.

## Strong testability

Prefer code that can be tested without network, device farms, or external
services. Add automated checks early (format, analyze, unit/widget tests) and
keep them green on every change.

## Authoritative backend (planned)

Sensitive game and social mechanics will eventually be validated by an
authoritative backend. Clients should not be the source of truth for
cheat-sensitive outcomes. This is a design principle for later lots — it is not
implemented in the foundation.

## Avoid overengineering

Do not introduce frameworks, layers, or dependencies “just in case”. Add
structure when a concrete need appears. Prefer Dart/Flutter built-ins when they
are enough.

## Incremental change

Prefer small, reviewable, reversible steps. Each lot should leave the
repository buildable, documented, and testable.

## Document structural evolution

Any structural or stack decision that shapes future work must be recorded
(architecture notes and/or ADRs) before or with the change that introduces it.
