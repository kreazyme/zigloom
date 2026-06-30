# Terms Screen

## Purpose

The Terms screen provides app-store-ready usage terms without distracting from the game flow.

The terms should be plain and narrow for an offline puzzle app.

## Screen Content

- Back button.
- Title: `Terms`.
- Effective date.
- Usage terms.
- Offline/local progress note.
- Contact section.

Do not include subscriptions, user accounts, online community rules, purchases, or leaderboard terms unless those features are actually added.

## UI Mockups

### Default State

```text
┌─────────────────────────────────────┐
│ [ Back ]                    Terms   │
│                                     │
│ Effective date: TBD                 │
│                                     │
│ Zigloom is an offline puzzle game.  │
│ Use the app for personal play and   │
│ do not attempt to copy, resell, or  │
│ misuse the app content.             │
│                                     │
│ Local progress                      │
│ Puzzle progress and settings are    │
│ stored on this device. Removing the │
│ app may remove that progress.       │
│                                     │
│ Changes                             │
│ Terms may be updated in future app  │
│ releases.                           │
│                                     │
│ Contact                             │
│ TBD                                 │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component     | Content                    | Behavior                  |
| ------------- | -------------------------- | ------------------------- |
| Back button   | Icon button or `Back`      | Returns to previous screen |
| Title         | `Terms`                    | No action                 |
| Terms content | Plain-language terms       | Scrolls if needed         |
| Contact       | Contact placeholder or link | Opens mail client only if configured |

## Navigation

| Action      | Destination     |
| ----------- | --------------- |
| Tap `Back`  | Previous screen |

## State Rules

### Standard

- Show terms copy in the selected locale.
- Keep content readable on small screens with vertical scrolling.

### Contact Not Configured

- Show `TBD` or omit the contact row until app-store metadata is ready.

## Data Needed

- `locale`
- `termsEffectiveDate`
- `supportContact`

## Acceptance Criteria

- Terms is separate from gameplay.
- Terms is reachable from Home, Onboarding, and Settings.
- Terms does not mention unsupported accounts, purchases, leaderboards, or online services.
- Terms includes a local progress note.
- Terms remains readable on small screens.
