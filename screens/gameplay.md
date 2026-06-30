# Gameplay Screen

## Purpose

The Gameplay screen is the focused puzzle surface where players draw one continuous path through the board.

The board is the main visual anchor. Controls should be quiet, familiar, and icon-led so the puzzle stays central.

## Screen Content

- Compact header with back or pause, puzzle number, timer, and moves.
- Responsive square or rectangular board.
- Numbered clue cells.
- Path cells, current path head, invalid feedback, and completion state.
- Icon controls: undo, reset, pause, settings.

Do not add distracting panels, ads, leaderboard widgets, chat, profile UI, or full instructions on this screen.

## UI Mockups

### Active Puzzle State

```text
┌─────────────────────────────────────┐
│ [ Pause ]  Puzzle 13       02:18    │
│           Moves 28                  │
│                                     │
│     ┌────┬────┬────┬────┬────┐      │
│     │ 1  │ o  │ o  │    │ 4  │      │
│     ├────┼────┼────┼────┼────┤      │
│     │    │    │ o  │    │    │      │
│     ├────┼────┼────┼────┼────┤      │
│     │ 2  │ o  │ o  │ o  │    │      │
│     ├────┼────┼────┼────┼────┤      │
│     │    │    │    │ o  │ 3  │      │
│     ├────┼────┼────┼────┼────┤      │
│     │    │    │    │ @  │    │      │
│     └────┴────┴────┴────┴────┘      │
│                                     │
│        [ Undo ] [ Reset ] [ Gear ]  │
│                                     │
└─────────────────────────────────────┘
```

### Invalid Move State

```text
┌─────────────────────────────────────┐
│ [ Pause ]  Puzzle 13       02:23    │
│           Moves 29                  │
│                                     │
│     ┌────┬────┬────┬────┬────┐      │
│     │ 1  │ o  │ o  │ !  │ 4  │      │
│     ├────┼────┼────┼────┼────┤      │
│     │    │    │ o  │    │    │      │
│     ├────┼────┼────┼────┼────┤      │
│     │ 2  │ o  │ o  │ o  │    │      │
│     ├────┼────┼────┼────┼────┤      │
│     │    │    │    │ o  │ 3  │      │
│     ├────┼────┼────┼────┼────┤      │
│     │    │    │    │ @  │    │      │
│     └────┴────┴────┴────┴────┘      │
│                                     │
│        That square breaks the path  │
│                                     │
│        [ Undo ] [ Reset ] [ Gear ]  │
└─────────────────────────────────────┘
```

### Completed Path State

```text
┌─────────────────────────────────────┐
│ [ Pause ]  Puzzle 13       03:04    │
│           Moves 42                  │
│                                     │
│     ┌────┬────┬────┬────┬────┐      │
│     │ 1  │ o  │ o  │ o  │ 4  │      │
│     ├────┼────┼────┼────┼────┤      │
│     │ o  │ o  │ o  │ o  │ o  │      │
│     ├────┼────┼────┼────┼────┤      │
│     │ 2  │ o  │ o  │ o  │ o  │      │
│     ├────┼────┼────┼────┼────┤      │
│     │ o  │ o  │ o  │ o  │ 3  │      │
│     ├────┼────┼────┼────┼────┤      │
│     │ o  │ o  │ o  │ o  │ o  │      │
│     └────┴────┴────┴────┴────┘      │
│                                     │
│             Solved                  │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component    | Content                         | Behavior                                      |
| ------------ | ------------------------------- | --------------------------------------------- |
| Pause button | Icon button or `Pause`          | Opens Pause screen or pause overlay           |
| Puzzle label | `Puzzle {number}`               | No action                                     |
| Timer        | Elapsed time                    | Pauses when Pause is open                     |
| Move count   | Current move count              | Updates after valid moves                     |
| Board        | Puzzle grid                     | Handles drag, tap-to-extend, and keyboard movement |
| Path head    | Current active cell             | Shows where the next move extends from        |
| Undo button  | Undo icon                       | Removes the last path step                    |
| Reset button | Reset icon                      | Confirms or immediately resets path           |
| Settings     | Gear icon                       | Opens Settings screen                         |

## Navigation

| Action                 | Destination              |
| ---------------------- | ------------------------ |
| Tap `Pause`            | Pause screen             |
| Tap `Settings`         | Settings screen          |
| Complete valid puzzle  | Completion Result screen |

## State Rules

### Empty Start

- Start with the path head on clue `1`.
- Only adjacent cells can be added.

### Active Path

- Valid moves extend the path.
- Reused cells are blocked.
- Numbered cells must be visited in ascending order.
- Progress persists locally after each valid move.

### Invalid Move

- Show short invalid feedback on the target cell.
- Keep the existing path unchanged.
- Use haptics or sound only if enabled.

### Completion

- Complete when every cell is covered and all clues are visited in order.
- Save solved state, elapsed time, moves, undo count, and best result.
- Unlock the next puzzle.
- Navigate to Completion Result.

## Data Needed

- `puzzle`
- `path`
- `currentRequiredNumber`
- `timerElapsed`
- `moveCount`
- `undoCount`
- `soundEnabled`
- `hapticsEnabled`
- `themeMode`

## Acceptance Criteria

- Gameplay keeps the board centered and stable.
- Gameplay supports drag input and tap-to-extend where practical.
- Gameplay validates adjacency, reused cells, and numbered order immediately.
- Gameplay includes undo, reset, pause, and settings controls.
- Gameplay persists in-progress path locally.
- Gameplay navigates to Completion Result only after a valid complete path.
