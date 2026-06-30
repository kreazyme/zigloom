# Onboarding Screen

## Purpose

The Onboarding screen teaches the core rule through a tiny board example before the player starts Puzzle 1.

The screen should be brief and visual. Players should understand that Zigloom is about drawing one continuous path, visiting numbers in order, and filling every square.

## Screen Content

- Zigloom title or small wordmark.
- One illustrated or playable example board.
- Short rule text.
- Primary action: `Start Puzzle 1`.
- Secondary legal links if required before first play.

Do not add long tutorials, account setup, difficulty quizzes, or multiple preference prompts.

## UI Mockups

### Rules State

```text
┌─────────────────────────────────────┐
│ ZIGLOOM                             │
│                                     │
│ Draw one path                       │
│                                     │
│        ┌────┬────┬────┐             │
│        │ 1  │ o  │ o  │             │
│        ├────┼────┼────┤             │
│        │    │    │ o  │             │
│        ├────┼────┼────┤             │
│        │ 3  │ o  │ 2  │             │
│        └────┴────┴────┘             │
│                                     │
│ Start at 1. Connect numbers in      │
│ order. Fill every square once.      │
│                                     │
│        ┌─────────────────────┐      │
│        │    START PUZZLE 1   │      │
│        └─────────────────────┘      │
│                                     │
│        Privacy Policy   Terms       │
└─────────────────────────────────────┘
```

### Invalid Move Teaching State

```text
┌─────────────────────────────────────┐
│ ZIGLOOM                             │
│                                     │
│ No diagonals. No repeats.           │
│                                     │
│        ┌────┬────┬────┐             │
│        │ 1  │ o  │ 3  │             │
│        ├────┼────┼────┤             │
│        │    │ !  │    │             │
│        ├────┼────┼────┤             │
│        │    │ o  │ 2  │             │
│        └────┴────┴────┘             │
│                                     │
│ A move must touch the path head     │
│ by an edge.                         │
│                                     │
│        ┌─────────────────────┐      │
│        │    START PUZZLE 1   │      │
│        └─────────────────────┘      │
│                                     │
│        Privacy Policy   Terms       │
└─────────────────────────────────────┘
```

## Component Behavior

| Component     | Content                              | Behavior                                |
| ------------- | ------------------------------------ | --------------------------------------- |
| Title         | `ZIGLOOM`                            | No action                               |
| Example board | `3x3` or `4x4` rule demonstration    | May animate path once or be playable    |
| Rule text     | Short active rule copy               | No action                               |
| Start button  | `Start Puzzle 1`                     | Saves onboarding completion and opens Puzzle 1 or Game List |
| Legal links   | `Privacy Policy`, `Terms`            | Opens legal pages                       |

## Navigation

| Action                    | Destination           |
| ------------------------- | --------------------- |
| Tap `Start Puzzle 1`      | Gameplay or Game List |
| Tap `Privacy Policy`      | Privacy Policy screen |
| Tap `Terms`               | Terms screen          |

## State Rules

### First-Time Player

- Show onboarding after Splash.
- Mark onboarding complete when the player taps `Start Puzzle 1`.
- Open Puzzle 1 if direct play is supported, otherwise open Game List with Puzzle 1 highlighted.

### Returning Player

- Skip onboarding from Splash.
- Keep the screen reachable from How To Play only if a future route needs it.

### Reduced Motion

- Show the solved example statically.
- Do not animate the path draw.

## Data Needed

- `hasCompletedOnboarding`
- `firstAvailablePuzzleNumber`
- `locale`

## Acceptance Criteria

- Onboarding teaches start number, ordered numbers, full board coverage, and no repeats.
- Onboarding uses a small board example instead of long text.
- Onboarding can be completed in one action.
- Onboarding stores completion locally.
- Onboarding includes legal access if required before first play.
