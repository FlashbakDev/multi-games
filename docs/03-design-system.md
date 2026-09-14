# Design system

Visual foundation for the multi-games mobile application.

## Design principles

1. **Obvious before clever** — Labels, hierarchy, and actions should be
   understood in a glance. Prefer clear structure over clever visual tricks.
2. **Touch-first** — Primary controls target comfortable thumb sizes
   (≥ ~48dp, CTAs ~52dp). Spacing and hit areas beat dense desktop layouts.
3. **Friendly but not childish** — Warm and playful tone without mascot
   clutter, neon gimmicks, or toy-like chrome.
4. **Short visual hierarchy** — Few text roles (`display`, titles, body,
   labels). Avoid long ladders of unused sizes.
5. **Immediate feedback** — Pressed / disabled / loading states are visible.
   Deeper micro-motion comes later; timing tokens already exist.
6. **Consistency over novelty** — Features consume shared tokens and
   primitives instead of inventing one-off colors, radii, or buttons.

## Philosophy

Sessions are short. The UI should feel warm, tactile, and instantly readable —
inspired by accessible learning / mini-game shells, without copying any
external brand identity.

## Colors

Semantic tokens via `AppColors` (`ThemeExtension`) + Material `ColorScheme`:

| Token | Light value |
|-------|-------------|
| primary | `#5B5FEF` |
| onPrimary | `#FFFFFF` |
| background | `#F7F8FC` |
| surface | `#FFFFFF` |
| textPrimary / onSurface | `#1F2430` |
| textSecondary | `#667085` |
| border | `#E4E7EC` |
| surfaceMuted | `#F2F4F7` |
| success / warning / danger | `#16A34A` / `#D97706` / `#DC2626` |
| disabled / onDisabled | `#D0D5DD` / `#98A2B3` |
| primaryPressed / primarySubtle | pressed + soft wash |

Access: `AppColors.of(context)` or `Theme.of(context).colorScheme` when the
Material mapping fits.

**Dark theme not implemented yet.**

## Typography

System fonts only (`AppTypography` → `TextTheme`):

- `displayLarge` 32 / w700
- `titleLarge` 22 / w700
- `titleMedium` 18 / w600
- `bodyLarge` 16 / w500
- `bodyMedium` 14 / w400
- `labelLarge` 16 / w600
- `labelMedium` 14 / w600

No `AppText` wrapper — use `Theme.of(context).textTheme`.

## Spacing

`AppSpacing`: xs 4 · sm 8 · md 12 · lg 16 · xl 24 · xxl 32 · xxxl 48

## Radius

`AppRadius`: sm 8 · md 12 · lg 16 · xl 24 · pill 999

## Motion

`AppMotion`: fast 120ms · normal 220ms · slow 360ms (+ `standard` /
`emphasized` curves). No product animations yet.

## Components

| Component | Role |
|-----------|------|
| `AppTheme.light` | Material 3 theme (ColorScheme, NavBar, buttons, cards, …) |
| `AppButton` | primary / secondary / danger, loading, icon, expanded |
| `AppCard` | surface + border + radius + padding |

## Usage rules

- Import `package:design_system/design_system.dart` only (not `src/…`).
- Do not hard-code shared colors, radii, or spacing when a token exists.
- Prefer `AppButton` for product CTAs.
- Keep feature screens free of design-token invention.

## Not implemented yet

- Dark mode (`AppTheme.dark`)
- Brand / custom fonts
- Large component library (chips, sheets, game cards, …)
- Custom motion / scale press feedback
- Illustrations, mascot, or marketing chrome
