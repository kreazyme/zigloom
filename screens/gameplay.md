# Gameplay Screen

## Purpose

The Gameplay screen is the focused puzzle surface where players draw one continuous path through the board.

The board is the main visual anchor. Controls should be quiet, familiar, and icon-led so the puzzle stays central.

## Screen Content

- Compact header with back or pause, puzzle number, timer, and moves.
- Responsive square or rectangular board.
- Numbered clue cells.
- Wall segments between adjacent cells.
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

### Puzzle With Walls

Walls are thick barriers drawn on grid edges between two adjacent cells. They do not occupy cells, and cells on both sides of a wall may still be visited. The path simply cannot cross that blocked edge.

```text
┌─────────────────────────────────────┐
│ [ Pause ]  Puzzle 24       01:12    │
│           Moves 16                  │
│                                     │
│   ┌───┬───┬───┬───┬───┬───┬───┐    │
│   │   │   │   │   │   │   │   │    │
│   ├───┼───┼━━━┼───┼───┼━━━┼───┤    │
│   │   │   │ 4 │   │   │ 5 │   │    │
│   ├───┼───┼───┼───┼───┼───┼───┤    │
│   │ 3 │   │   │   │   │   │   │    │
│   ├───┼───┼───║───┼───┼───┼━━━┤    │
│   │   │   │   ║   │   │   │   │    │
│   ├───┼───┼━━━╚━━━┼───┼───┼───┤    │
│   │   │ 2 │   │ 1 │   │ 6 │   │    │
│   ├───┼───┼───║───┼───┼━━━┼───┤    │
│   │   │   │   ║   │   │ 7 │   │    │
│   └───┴───┴───┴───┴───┴───┴───┘    │
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
| Board        | Puzzle grid, clues, walls       | Handles drag, tap-to-extend, and keyboard movement |
| Path head    | Current active cell             | Shows where the next move extends from        |
| Wall segment | Thick edge between two cells    | Blocks movement across that edge              |
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
- Adjacent cells separated by a wall cannot be added directly.

### Active Path

- Valid moves extend the path.
- Reused cells are blocked.
- Wall crossings are blocked.
- Numbered cells must be visited in ascending order.
- Progress persists locally after each valid move.

### Invalid Move

- Show short invalid feedback on the target cell.
- If the attempted move crosses a wall, show wall-specific feedback such as `A wall blocks the path`.
- Keep the existing path unchanged.
- Use haptics or sound only if enabled.

### Completion

- Complete when every cell is covered, all clues are visited in order, and no path segment crosses a wall.
- Save solved state, elapsed time, moves, undo count, and best result.
- Unlock the next puzzle.
- Navigate to Completion Result.

## Wall Rules

- A wall is an edge barrier between exactly two orthogonally adjacent cells.
- Walls may be horizontal or vertical.
- Walls never sit inside a cell and never remove a cell from the puzzle.
- A move from cell `A` to adjacent cell `B` is invalid when a wall exists on the shared edge.
- Drag input should stop extending the path when the drag crosses a wall; the current path remains unchanged.
- Tap-to-extend should reject wall crossings immediately.
- Keyboard movement should reject wall crossings the same way as touch input.
- Walls should remain visible under or beside nearby path graphics.
- Wall rendering should use high-contrast, thick segments so players can distinguish walls from ordinary cell borders.

### Wall Data Shape

Wall data should be stored as blocked edges, not blocked cells. Either representation is acceptable:

```text
walls: [
  { from: { row: 1, column: 2 }, to: { row: 2, column: 2 } },
  { from: { row: 4, column: 6 }, to: { row: 4, column: 7 } }
]
```

or:

```text
walls: [
  { row: 1, column: 2, edge: bottom },
  { row: 4, column: 6, edge: right }
]
```

The model should normalize wall lookup so validation can ask: `isWallBetween(currentCell, targetCell)`.

## Data Needed

- `puzzle`
- `walls`
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
- Gameplay validates wall crossings immediately.
- Gameplay renders wall segments as barriers between cells, not as blocked cells.
- Gameplay includes undo, reset, pause, and settings controls.
- Gameplay persists in-progress path locally.
- Gameplay navigates to Completion Result only after a valid complete path.
