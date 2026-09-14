# ADR-0003 — Design system foundation

## Status

Accepted

## Context

LOT 0.2 delivered navigation with a default Material seed theme. Upcoming
product UI (home, catalogue, profile) needs consistent color, type, spacing,
and a small set of primitives — without adopting a third-party UI kit or
building a huge component catalog early.

## Decision

- Maintain an **internal** Flutter package `packages/design_system`.
- Build on **Material 3** (`ThemeData`, `ColorScheme`, component themes).
- Centralize **semantic tokens** (`AppColors` ThemeExtension, spacing,
  radius, motion, typography) rather than a generic shade ladder.
- Ship only essential primitives for now: **`AppButton`**, **`AppCard`**.
- Use **system fonts** temporarily; brand typefaces come later.
- Do **not** implement a full dark theme yet, but keep token structure ready
  for `AppTheme.dark`.
- Do **not** add Google Fonts, icon packs, animation packages, or external UI
  libraries.

## Consequences

### Positive

- Features can share one visual language via a single import.
- Theme and tokens are unit/widget-testable in isolation.
- Material component themes (e.g. `NavigationBar`) stay coherent without a
  custom bottom bar.
- Small surface area reduces premature abstraction.

### Negative

- Designers/devs must extend the package deliberately when new patterns
  appear.
- System fonts delay final brand expression.
- Missing dark theme may force a follow-up pass on contrast tokens.

## Alternatives considered

- **Ad-hoc theme in `apps/mobile` only** — would leak tokens across features
  and block reuse.
- **External UI kit / Widgetbook** — too heavy for foundation; Storybook-like
  tooling deferred.
- **Full color scales (blue100…)** — unused complexity; semantic tokens win.
- **Implement dark mode now** — not required by product yet; risk of
  unfinished dual themes.
