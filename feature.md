# Zigloom Feature Brief

## Product Goal

Zigloom is a Flutter clone inspired by LinkedIn's Zip puzzle game. The app should deliver short offline logic puzzles where players draw one continuous path through a grid, connect numbered cells in order, and cover every cell exactly once.

## Core Game

Zip is a grid path puzzle:

- The board is a rectangular grid of cells.
- Some cells contain ordered numbers, starting at `1`.
- The player starts from `1` and draws a continuous path through adjacent cells.
- The path must visit numbered cells in ascending order: `1`, `2`, `3`, and so on.
- The path must cover every cell on the board.
- A valid solution has no gaps, no repeated cells, and no broken path segments.

Public references describe Zip as a daily puzzle about filling a grid with one continuous line and connecting numbered squares in order without leaving gaps:

- [Polygon: LinkedIn has fun games on it and I'm not making that up](https://www.polygon.com/gaming/561445/linkedin-has-fun-games-zip-pinpoint)
- [Wired: LinkedIn Games Are Still the Best Part of LinkedIn](https://www.wired.com/story/games-are-still-the-best-part-of-linkedin)

## Target Experience

The first release should feel like a polished mobile-first puzzle app:

- Quick launch into the next available puzzle.
- Clear numbered anchors and path feedback.
- Smooth drag input for touch devices.
- Keyboard-friendly movement for desktop/web where practical.
- Immediate validation feedback for invalid moves.
- Completion screen with time and moves.
- Linear puzzle progression from low to high difficulty or puzzle number.

## Recommended Screens

### Splash

Purpose: give the app a clean launch moment while local state is prepared.

Recommended details:

- Show the Zigloom logo or wordmark.
- Load saved preferences: theme, locale, sound, haptics, onboarding status.
- Load bundled puzzle metadata and local progression state.
- Route first-time players to onboarding, otherwise route directly to home.
- Keep this screen short because the game is fully offline and should not wait for network calls.

### Onboarding

Introduce the rules with a tiny playable or illustrated example:

- Start at `1`.
- Connect numbers in order.
- Fill every square.
- Avoid crossing or revisiting cells.

Recommended details:

- Keep onboarding to one or two short pages.
- Use a small `3x3` or `4x4` board example instead of long text.
- Include a clear continue button into the first available puzzle.
- Store completion locally so returning players skip onboarding.

### Home

Purpose: act as the main menu and clean entry point into offline play.

Recommended details:

- Show the game title or logo as the main visual anchor.
- Provide a primary Play button that opens the game list.
- Provide secondary buttons for settings, how to play, privacy policy, and terms.
- Show a small progress summary: solved puzzles and current highest unlocked puzzle.
- Continue should open the next unfinished puzzle directly if there is in-progress state.
- Keep the screen simple and menu-like rather than showing the full level grid.

### Game List

Purpose: let players choose puzzles from a linear level progression.

Recommended details:

- Navigate here from the Home Play button.
- Show all bundled puzzles in order from low to high puzzle number or difficulty.
- Present puzzles as a compact level grid or rows, similar to mobile level-select screens.
- Show each puzzle number clearly.
- Show solved puzzles with a completed state.
- Highlight the next available unsolved puzzle.
- Show locked puzzles with a lock icon and disabled interaction.
- Unlock puzzles continuously: solving a lower puzzle opens the next higher puzzle.
- Allow replaying solved lower puzzles without blocking progression.
- Include a back button to Home.
- Show total progress, such as solved count, at the bottom or top.
- Avoid date-based archive language; this is a level list, not a daily puzzle calendar.

### Gameplay

Purpose: provide the focused board interaction for solving a Zip-style puzzle.

Recommended details:

- Show a compact header with puzzle number, timer, and move count.
- Keep the board as the visual center of the screen.
- Support drag input for touch and tap-to-extend where practical.
- Support undo, reset, pause, and settings controls.
- Highlight numbered cells, current path head, invalid moves, and completed path state.
- Validate moves immediately: adjacent movement, no reused cells, numbered cells in ascending order.
- Persist in-progress path locally so closing the app does not lose the current puzzle.
- Avoid distracting panels; this screen should feel quiet and puzzle-first.

### Pause

Purpose: let players step away from an active puzzle without losing progress.

Recommended details:

- Offer resume, reset, restart puzzle, settings, and return home.
- Pause the visible timer if the timer is part of scoring.
- Keep the puzzle state in memory and local storage.

### Completion Result

Purpose: celebrate solving the puzzle and give players a useful summary.

Recommended details:

- Show solved state, elapsed time, move count, undo count if tracked, and puzzle number.
- Offer replay, next puzzle, and return home.
- Save best result locally and unlock the next higher puzzle.

### Settings

Purpose: centralize local preferences and low-risk app controls.

Recommended details:

- Theme mode.
- Sound and haptics.
- Locale.
- Links to how to play, privacy policy, and terms.

### How To Play

Purpose: explain the rules for new or returning players without requiring onboarding again.

Recommended details:

- Explain the core rule: draw one continuous path through the whole board.
- Explain that numbered cells must be connected in ascending order.
- Show a small example puzzle and solved path.
- Mention invalid cases: gaps, repeated cells, diagonal moves, and visiting a later number too early.
- Keep this page available from home, gameplay, and settings.

### Legal Pages

Purpose: provide app-store-ready compliance pages while keeping gameplay uncluttered.

Recommended details:

- Keep privacy policy and terms pages separate from gameplay.
- Make both reachable from settings and onboarding.
- State clearly that gameplay is offline and progress is stored locally.
- Include a data deletion note if the only stored data is local device progress.

## Game Rules

### Cell Model

Each cell should track:

- Row and column.
- Optional clue number.
- Path order if selected.
- Whether it is the current path head.
- Visual state: empty, path, clue, invalid, complete.

### Move Rules

A move is valid when:

- The next cell is orthogonally adjacent to the current path head.
- The next cell has not already been used.
- If the next cell is numbered, it is the next required number.
- The move does not make the puzzle impossible under basic constraints.

### Completion Rules

The puzzle is complete when:

- Every cell is included in the path.
- All numbered cells are visited in ascending order.
- The path is continuous from the first number to the final cell.

## MVP Scope

- Static set of bundled puzzles.
- Linear puzzle progression from low to high puzzle number or difficulty.
- Drag and tap input.
- Undo and reset.
- Completion detection.
- Local best time and solved state.
- Light and dark theme support.
- English and Vietnamese strings through `slang`.

## Later Enhancements

- Puzzle generator and validator.
- Accessibility labels for board cells.

## Non-Goals For MVP

- Multiplayer.
- Login or user accounts.
- Online leaderboards.
- Monetization.
- Exact LinkedIn branding, assets, names, or proprietary puzzle data.

## Design Direction

The app should feel focused, crisp, and calm:

- Use a compact, centered board as the main visual anchor.
- Keep controls familiar and icon-led.
- Avoid decorative marketing sections inside the app.
- Use strong contrast between empty cells, path cells, clue cells, and invalid cells.
- Keep animations short and functional: path draw, invalid bump, completion celebration.

## Technical Direction

- Build with Flutter and Material.
- Use `go_router` for all screen navigation.
- Use Riverpod for app and game state.
- Keep puzzle domain logic independent from widgets.
- Store local progress with `SharedPreferences` through helper/provider layers.
- Localize display strings with existing `slang` setup.
- Add focused unit tests for puzzle validation before expanding UI complexity.
