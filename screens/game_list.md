# Game List Screen

## Purpose

The Game List screen lets players choose puzzles from a linear offline progression.

The list should feel compact and level-select-like. It is not a daily archive and should not use dates.

## Screen Content

- Back button to Home.
- Screen title: `Puzzles`.
- Progress summary.
- Compact numbered puzzle grid.
- Solved, current, available, and locked states.

Do not add calendars, streaks, leaderboards, social sharing, accounts, or online ranking.

## UI Mockups

### Returning Player State

```text
┌─────────────────────────────────────┐
│ [ Back ]                 Puzzles    │
│                                     │
│  12 / 120 solved       Next: 13     │
│                                     │
│ ┌────┬────┬────┬────┬────┬────┐    │
│ │ ok1│ ok2│ ok3│ ok4│ ok5│ ok6│    │
│ ├────┼────┼────┼────┼────┼────┤    │
│ │ ok7│ ok8│ ok9│ok10│ok11│ok12│    │
│ ├────┼────┼────┼────┼────┼────┤    │
│ │ 13 │ 14 │ L  │ L  │ L  │ L  │    │
│ ├────┼────┼────┼────┼────┼────┤    │
│ │ L  │ L  │ L  │ L  │ L  │ L  │    │
│ └────┴────┴────┴────┴────┴────┘    │
│                                     │
│ Puzzle 13 is ready                  │
│                                     │
└─────────────────────────────────────┘
```

### First-Time State

```text
┌─────────────────────────────────────┐
│ [ Back ]                 Puzzles    │
│                                     │
│  Ready to start        Puzzle 1     │
│                                     │
│ ┌────┬────┬────┬────┬────┬────┐    │
│ │ 1  │ L  │ L  │ L  │ L  │ L  │    │
│ ├────┼────┼────┼────┼────┼────┤    │
│ │ L  │ L  │ L  │ L  │ L  │ L  │    │
│ ├────┼────┼────┼────┼────┼────┤    │
│ │ L  │ L  │ L  │ L  │ L  │ L  │    │
│ └────┴────┴────┴────┴────┴────┘    │
│                                     │
│ Solve a puzzle to unlock the next   │
│ one.                                │
│                                     │
└─────────────────────────────────────┘
```

### All Solved State

```text
┌─────────────────────────────────────┐
│ [ Back ]                 Puzzles    │
│                                     │
│  120 / 120 solved      Complete     │
│                                     │
│ ┌────┬────┬────┬────┬────┬────┐    │
│ │ ok1│ ok2│ ok3│ ok4│ ok5│ ok6│    │
│ ├────┼────┼────┼────┼────┼────┤    │
│ │ ok7│ ok8│ ok9│ok10│ok11│ok12│    │
│ ├────┼────┼────┼────┼────┼────┤    │
│ │ok13│ok14│ok15│ok16│ok17│ok18│    │
│ └────┴────┴────┴────┴────┴────┘    │
│                                     │
│ Pick any puzzle to replay.          │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component        | Content                            | Behavior                           |
| ---------------- | ---------------------------------- | ---------------------------------- |
| Back button      | Icon button or `Back`              | Returns to Home                    |
| Title            | `Puzzles`                          | No action                          |
| Progress summary | Solved count and next puzzle state | No action                          |
| Solved tile      | Puzzle number with completed mark  | Opens solved puzzle for replay     |
| Current tile     | Next available unsolved puzzle     | Opens Gameplay                     |
| Available tile   | Unlocked unsolved puzzle           | Opens Gameplay                     |
| Locked tile      | Lock icon                          | Disabled; optional locked feedback |

## Navigation

| Action               | Destination     |
| -------------------- | --------------- |
| Tap `Back`           | Home screen     |
| Tap solved puzzle    | Gameplay screen |
| Tap available puzzle | Gameplay screen |
| Tap locked puzzle    | No navigation   |

## State Rules

### First-Time Player

- Show Puzzle 1 as available.
- Show all higher puzzles as locked.

### Returning Player

- Show solved puzzles as replayable.
- Show the next unsolved puzzle as highlighted.
- Show later puzzles as locked unless already unlocked.

### In-Progress Puzzle

- Mark the in-progress puzzle with the current highlight.
- Opening it resumes saved path state.

### All Puzzles Solved

- Show all puzzles as solved and replayable.
- Replace next puzzle copy with `Complete` or `Pick any puzzle to replay`.

## Data Needed

- `puzzles`
- `solvedPuzzleIds`
- `totalPuzzleCount`
- `highestUnlockedPuzzleNumber`
- `inProgressPuzzleNumber`
- `bestResultsByPuzzle`

## Acceptance Criteria

- Game List shows bundled puzzles in linear order.
- Solved puzzles are replayable.
- Locked puzzles are visibly disabled.
- The next available puzzle is highlighted.
- The screen includes a back path to Home.
- The screen avoids date-based archive language.
