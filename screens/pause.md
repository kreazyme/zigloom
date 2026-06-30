# Pause Screen

## Purpose

The Pause screen lets players step away from an active puzzle without losing progress.

It should pause the timer, keep the puzzle state intact, and offer only the actions needed to continue or leave.

## Screen Content

- Puzzle number.
- Paused status.
- Resume action.
- Reset or restart action.
- Settings action.
- Return Home action.

Do not show the full game list, progress grid, leaderboard, ads, or legal text here.

## UI Mockups

### Default State

```text
┌─────────────────────────────────────┐
│                                     │
│              Puzzle 13              │
│                                     │
│               Paused                │
│                                     │
│        ┌─────────────────────┐      │
│        │       RESUME        │      │
│        └─────────────────────┘      │
│                                     │
│        ┌─────────────────────┐      │
│        │       RESET         │      │
│        └─────────────────────┘      │
│                                     │
│        ┌─────────────────────┐      │
│        │      SETTINGS       │      │
│        └─────────────────────┘      │
│                                     │
│        Return Home                  │
│                                     │
└─────────────────────────────────────┘
```

### Reset Confirm State

```text
┌─────────────────────────────────────┐
│                                     │
│              Reset puzzle?          │
│                                     │
│ Your current path for Puzzle 13     │
│ will be cleared.                    │
│                                     │
│        ┌─────────────────────┐      │
│        │     RESET PUZZLE    │      │
│        └─────────────────────┘      │
│                                     │
│              Cancel                 │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component   | Content                 | Behavior                                  |
| ----------- | ----------------------- | ----------------------------------------- |
| Puzzle label | `Puzzle {number}`      | No action                                 |
| Status      | `Paused`                | No action                                 |
| Resume      | Primary button          | Returns to Gameplay and resumes timer     |
| Reset       | Secondary button        | Opens reset confirmation or resets path   |
| Settings    | Secondary button        | Opens Settings screen                     |
| Return Home | Text button             | Saves progress and returns to Home        |

## Navigation

| Action            | Destination     |
| ----------------- | --------------- |
| Tap `Resume`      | Gameplay screen |
| Tap `Settings`    | Settings screen |
| Tap `Return Home` | Home screen     |
| Confirm reset     | Gameplay screen |

## State Rules

### Paused

- Timer stops while Pause is visible.
- Current path remains saved locally.
- Board input is disabled behind the pause surface.

### Reset Confirm

- Reset requires confirmation if the path contains any player moves.
- Cancel returns to Pause without changing the path.

### Return Home

- Save current path.
- Keep `inProgressPuzzleNumber` set.
- Home should show the in-progress state.

## Data Needed

- `puzzleNumber`
- `path`
- `timerElapsed`
- `moveCount`
- `hasUnsavedPathMoves`

## Acceptance Criteria

- Pause stops the timer.
- Pause preserves the active puzzle path.
- Pause offers resume, reset, settings, and return home.
- Reset confirmation prevents accidental path loss.
- Return Home keeps the puzzle resumable.
