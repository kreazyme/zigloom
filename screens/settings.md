# Settings Screen

## Purpose

The Settings screen centralizes local preferences and low-risk app controls.

Settings should be concise and practical. The app is offline, so this screen should not imply accounts, cloud sync, or server-side data.

## Screen Content

- Back button.
- Theme mode control.
- Sound toggle.
- Haptics toggle.
- Locale selector.
- Links to How To Play, Privacy Policy, and Terms.

Do not add account settings, subscriptions, notifications, cloud sync, profile fields, or leaderboard options.

## UI Mockups

### Default State

```text
┌─────────────────────────────────────┐
│ [ Back ]                Settings    │
│                                     │
│ Appearance                          │
│ ┌───────────────────────────────┐   │
│ │ Theme        System  Light Dark│   │
│ └───────────────────────────────┘   │
│                                     │
│ Play                                │
│ ┌───────────────────────────────┐   │
│ │ Sound                     On  │   │
│ │ Haptics                   On  │   │
│ └───────────────────────────────┘   │
│                                     │
│ Language                            │
│ ┌───────────────────────────────┐   │
│ │ English                    ▾  │   │
│ └───────────────────────────────┘   │
│                                     │
│ How To Play                         │
│ Privacy Policy                      │
│ Terms                               │
│                                     │
└─────────────────────────────────────┘
```

### Locale Menu State

```text
┌─────────────────────────────────────┐
│ [ Back ]                Settings    │
│                                     │
│ Language                            │
│ ┌───────────────────────────────┐   │
│ │ English                    x  │   │
│ │ Vietnamese                   │   │
│ └───────────────────────────────┘   │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component       | Content                         | Behavior                              |
| --------------- | ------------------------------- | ------------------------------------- |
| Back button     | Icon button or `Back`           | Returns to previous screen            |
| Theme control   | `System`, `Light`, `Dark`       | Saves theme preference locally        |
| Sound toggle    | `On` or `Off`                   | Saves sound preference locally        |
| Haptics toggle  | `On` or `Off`                   | Saves haptics preference locally      |
| Locale selector | `English`, `Vietnamese`         | Saves locale preference locally       |
| How To Play     | Text row                        | Opens How To Play screen              |
| Privacy Policy  | Text row                        | Opens Privacy Policy screen           |
| Terms           | Text row                        | Opens Terms screen                    |

## Navigation

| Action               | Destination           |
| -------------------- | --------------------- |
| Tap `Back`           | Previous screen       |
| Tap `How To Play`    | How To Play screen    |
| Tap `Privacy Policy` | Privacy Policy screen |
| Tap `Terms`          | Terms screen          |

## State Rules

### Theme Mode

- Default to `System`.
- Apply changes immediately.
- Persist locally.

### Sound And Haptics

- Default to enabled unless platform limitations require otherwise.
- Use toggles for binary settings.
- Persist locally.

### Locale

- Show supported locales only.
- Apply changes immediately when practical.
- Persist locally.

## Data Needed

- `themeMode`
- `soundEnabled`
- `hapticsEnabled`
- `locale`
- `previousRoute`

## Acceptance Criteria

- Settings includes theme, sound, haptics, and locale controls.
- Settings links to How To Play, Privacy Policy, and Terms.
- Settings changes are stored locally.
- Settings can be opened from Home and Gameplay.
- Settings contains no account, cloud, subscription, leaderboard, or social options.
