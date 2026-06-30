# Completion Result Screen

## Purpose

The Completion Result screen celebrates a solved puzzle and gives the player a useful summary before the next action.

The celebration should be short and functional: solved state first, then time, moves, and navigation.

## Screen Content

- Solved puzzle number.
- Completion summary.
- Elapsed time.
- Move count.
- Undo count if tracked.
- Best result indicator.
- Primary action: `Next Puzzle` when available.
- Secondary actions: `Replay` and `Home`.

Do not add social share, leaderboard, login, streak pressure, or monetization prompts.

## UI Mockups

### Next Puzzle Available State

```text
┌─────────────────────────────────────┐
│                                     │
│              Solved                 │
│             Puzzle 13               │
│                                     │
│        ┌─────────────────────┐      │
│        │ Time        03:04   │      │
│        │ Moves       42      │      │
│        │ Undos       3       │      │
│        │ Best        New     │      │
│        └─────────────────────┘      │
│                                     │
│        ┌─────────────────────┐      │
│        │     NEXT PUZZLE     │      │
│        └─────────────────────┘      │
│                                     │
│        Replay          Home         │
│                                     │
└─────────────────────────────────────┘
```

### All Puzzles Solved State

```text
┌─────────────────────────────────────┐
│                                     │
│              Solved                 │
│             Puzzle 120              │
│                                     │
│        ┌─────────────────────┐      │
│        │ Time        04:12   │      │
│        │ Moves       58      │      │
│        │ Undos       1       │      │
│        │ Best        New     │      │
│        └─────────────────────┘      │
│                                     │
│        All puzzles complete         │
│                                     │
│        ┌─────────────────────┐      │
│        │       PUZZLES       │      │
│        └─────────────────────┘      │
│                                     │
│        Replay          Home         │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component      | Content                          | Behavior                              |
| -------------- | -------------------------------- | ------------------------------------- |
| Solved label   | `Solved`                         | No action                             |
| Puzzle label   | `Puzzle {number}`                | No action                             |
| Summary card   | Time, moves, undos, best result  | No action                             |
| Next Puzzle    | Primary button                   | Opens next unlocked puzzle            |
| Puzzles        | Primary button when all solved   | Opens Game List                       |
| Replay         | Text or secondary button         | Restarts solved puzzle                |
| Home           | Text or secondary button         | Opens Home                            |

## Navigation

| Action              | Destination      |
| ------------------- | ---------------- |
| Tap `Next Puzzle`   | Gameplay screen  |
| Tap `Puzzles`       | Game List screen |
| Tap `Replay`        | Gameplay screen  |
| Tap `Home`          | Home screen      |

## State Rules

### Solved With Next Puzzle

- Save solved state for the current puzzle.
- Save best result if time or moves improve.
- Unlock the next puzzle.
- Show `Next Puzzle` as the primary action.

### All Puzzles Solved

- Save solved state.
- Show all-complete copy.
- Replace `Next Puzzle` with `Puzzles`.

### Replay

- Keep solved state and best result.
- Start the selected puzzle with an empty current path.

## Data Needed

- `puzzleNumber`
- `nextPuzzleNumber`
- `elapsedTime`
- `moveCount`
- `undoCount`
- `previousBestResult`
- `isNewBest`
- `totalPuzzleCount`

## Acceptance Criteria

- Completion Result shows puzzle number, time, moves, and best-result status.
- Completion Result saves local progress.
- Completion Result unlocks the next puzzle when available.
- Completion Result offers next puzzle, replay, and home.
- Completion Result handles the all-puzzles-solved case.
