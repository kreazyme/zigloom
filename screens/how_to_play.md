# How To Play Screen

## Purpose

The How To Play screen explains the rules for new or returning players without forcing onboarding again.

It should use a compact example board and direct rule copy. The player should leave knowing what counts as a valid path.

## Screen Content

- Back button.
- Title: `How To Play`.
- Small unsolved and solved example board.
- Core rules.
- Invalid examples.
- Primary action back to the previous play context if opened from Gameplay or Home.

Do not add strategy essays, external links, daily puzzle language, or long onboarding-style pages.

## UI Mockups

### Default State

```text
┌─────────────────────────────────────┐
│ [ Back ]            How To Play     │
│                                     │
│ Fill the board with one path.       │
│                                     │
│     ┌────┬────┬────┐                │
│     │ 1  │ o  │ o  │                │
│     ├────┼────┼────┤                │
│     │    │    │ o  │                │
│     ├────┼────┼────┤                │
│     │ 3  │ o  │ 2  │                │
│     └────┴────┴────┘                │
│                                     │
│ Rules                               │
│ - Start at 1.                       │
│ - Connect numbers in order.         │
│ - Move up, down, left, or right.     │
│ - Use every square exactly once.     │
│                                     │
│ Avoid                               │
│ - Gaps                              │
│ - Repeated squares                  │
│ - Diagonal moves                    │
│ - Visiting a later number early     │
│                                     │
└─────────────────────────────────────┘
```

### From Gameplay State

```text
┌─────────────────────────────────────┐
│ [ Back ]            How To Play     │
│                                     │
│ Fill the board with one path.       │
│                                     │
│     ┌────┬────┬────┐                │
│     │ 1  │ o  │ o  │                │
│     ├────┼────┼────┤                │
│     │    │    │ o  │                │
│     ├────┼────┼────┤                │
│     │ 3  │ o  │ 2  │                │
│     └────┴────┴────┘                │
│                                     │
│        ┌─────────────────────┐      │
│        │    BACK TO PUZZLE   │      │
│        └─────────────────────┘      │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component     | Content                         | Behavior                         |
| ------------- | ------------------------------- | -------------------------------- |
| Back button   | Icon button or `Back`           | Returns to previous screen       |
| Example board | Small solved board              | No action or one short animation |
| Rules         | Core valid path rules           | No action                        |
| Avoid list    | Invalid move examples           | No action                        |
| Back to Puzzle | Primary button when applicable | Returns to Gameplay              |

## Navigation

| Action                | Destination     |
| --------------------- | --------------- |
| Tap `Back`            | Previous screen |
| Tap `Back to Puzzle`  | Gameplay screen |

## State Rules

### Opened From Home

- Back returns to Home.
- No gameplay-specific call to action is required.

### Opened From Gameplay

- Pause timer while this screen is visible if it replaces gameplay.
- Preserve current puzzle path.
- Show `Back to Puzzle` as the primary action.

### Reduced Motion

- Show a static solved example board.

## Data Needed

- `previousRoute`
- `activePuzzleNumber`
- `locale`

## Acceptance Criteria

- How To Play explains one continuous path, ordered numbers, and full board coverage.
- How To Play names invalid cases: gaps, repeated cells, diagonal moves, and early later numbers.
- How To Play includes a small board example.
- How To Play is reachable from Home, Gameplay, and Settings.
- How To Play preserves active gameplay state when opened from Gameplay.
