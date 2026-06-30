# Home Screen

## Purpose

The Home screen is the app's main menu. It gives players a clear entry point into offline puzzle play, shows lightweight local progress, and provides access to basic app pages.

The Home screen does not show the full game list. The `Play` button opens the Game List screen, unless there is an in-progress puzzle that should be resumed directly.

## Screen Content

- Game title or logo: `Zigloom`.
- Local progress summary.
- Primary action: `Play`.
- Secondary action: `How To Play`.
- Settings entry.
- Legal links: `Privacy Policy` and `Terms`.

Do not add login, account, profile, shop, leaderboard, online sync, or social features.

## UI Mockups

### Default State

```text
┌─────────────────────────────────────┐
│                                     │
│                         [ Settings ]│
│                                     │
│                                     │
│              ZIGLOOM                │
│                                     │
│        ┌─────────────────────┐      │
│        │     12 / 120 solved │      │
│        │     Next: Puzzle 13 │      │
│        └─────────────────────┘      │
│                                     │
│                                     │
│        ┌─────────────────────┐      │
│        │        PLAY         │      │
│        └─────────────────────┘      │
│                                     │
│        ┌─────────────────────┐      │
│        │     HOW TO PLAY     │      │
│        └─────────────────────┘      │
│                                     │
│                                     │
│        Privacy Policy   Terms       │
│                                     │
└─────────────────────────────────────┘
```

### First-Time State

```text
┌─────────────────────────────────────┐
│                                     │
│                         [ Settings ]│
│                                     │
│                                     │
│              ZIGLOOM                │
│                                     │
│        ┌─────────────────────┐      │
│        │ Ready to start      │      │
│        │ Puzzle 1            │      │
│        └─────────────────────┘      │
│                                     │
│                                     │
│        ┌─────────────────────┐      │
│        │        PLAY         │      │
│        └─────────────────────┘      │
│                                     │
│        ┌─────────────────────┐      │
│        │     HOW TO PLAY     │      │
│        └─────────────────────┘      │
│                                     │
│                                     │
│        Privacy Policy   Terms       │
│                                     │
└─────────────────────────────────────┘
```

### In-Progress State

```text
┌─────────────────────────────────────┐
│                                     │
│                         [ Settings ]│
│                                     │
│                                     │
│              ZIGLOOM                │
│                                     │
│        ┌─────────────────────┐      │
│        │     12 / 120 solved │      │
│        │     Puzzle 13 open  │      │
│        └─────────────────────┘      │
│                                     │
│        Puzzle 13 in progress        │
│                                     │
│        ┌─────────────────────┐      │
│        │        PLAY         │      │
│        └─────────────────────┘      │
│                                     │
│        ┌─────────────────────┐      │
│        │     HOW TO PLAY     │      │
│        └─────────────────────┘      │
│                                     │
│                                     │
│        Privacy Policy   Terms       │
│                                     │
└─────────────────────────────────────┘
```

### All Puzzles Solved State

```text
┌─────────────────────────────────────┐
│                                     │
│                         [ Settings ]│
│                                     │
│                                     │
│              ZIGLOOM                │
│                                     │
│        ┌─────────────────────┐      │
│        │    120 / 120 solved │      │
│        │    All puzzles done │      │
│        └─────────────────────┘      │
│                                     │
│                                     │
│        ┌─────────────────────┐      │
│        │        PLAY         │      │
│        └─────────────────────┘      │
│                                     │
│        ┌─────────────────────┐      │
│        │     HOW TO PLAY     │      │
│        └─────────────────────┘      │
│                                     │
│                                     │
│        Privacy Policy   Terms       │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component        | Content                            | Behavior                                |
| ---------------- | ---------------------------------- | --------------------------------------- |
| Settings         | Icon button or small button        | Opens Settings screen                   |
| Title            | `ZIGLOOM`                          | No action                               |
| Subtitle         | `Offline logic puzzles`            | No action                               |
| Progress summary | Solved count and next puzzle state | No action                               |
| Play             | Primary button                     | Opens in-progress Gameplay or Game List |
| How To Play      | Secondary button                   | Opens How To Play screen                |
| Privacy Policy   | Text link                          | Opens Privacy Policy screen             |
| Terms            | Text link                          | Opens Terms screen                      |

## Navigation

| Action                                | Destination           |
| ------------------------------------- | --------------------- |
| Tap `Play` with in-progress puzzle    | Gameplay screen       |
| Tap `Play` without in-progress puzzle | Game List screen      |
| Tap `How To Play`                     | How To Play screen    |
| Tap `Settings`                        | Settings screen       |
| Tap `Privacy Policy`                  | Privacy Policy screen |
| Tap `Terms`                           | Terms screen          |

## State Rules

### First-Time Player

- Show `Ready to start Puzzle 1`.
- `Play` opens Game List with Puzzle 1 available.

### Returning Player

- Show solved count and next puzzle number.
- `Play` opens Game List with the next available puzzle highlighted.

### In-Progress Puzzle

- Show `Puzzle {number} in progress`.
- `Play` opens that puzzle directly.

### All Puzzles Solved

- Show `{totalPuzzleCount} / {totalPuzzleCount} solved`.
- Show `All puzzles done`.
- `Play` opens Game List so players can replay puzzles.

## Data Needed

- `solvedPuzzleCount`
- `totalPuzzleCount`
- `highestUnlockedPuzzleNumber`
- `inProgressPuzzleNumber`
- `hasCompletedOnboarding`

## Acceptance Criteria

- Home has one obvious primary action: `Play`.
- Home does not contain the full game list.
- Home provides access to Settings, How To Play, Privacy Policy, and Terms.
- Home uses only local device progress.
- Home handles first-time, returning, in-progress, and all-solved states.
- Home does not include login, account, profile, shop, leaderboard, online sync, or social features.
