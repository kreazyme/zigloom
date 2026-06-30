# Splash Screen

## Purpose

The Splash screen gives Zigloom a short launch moment while local app state is loaded. It should feel calm and precise, like the first mark of a path being placed on the board.

The Splash screen does not wait for network calls because the game is fully offline.

## Screen Content

- Zigloom wordmark or logo.
- Small path motif or loading mark.
- Optional loading status for local setup only.

Do not add ads, account checks, online sync, remote config, or promotional copy.

## UI Mockups

### Default State

```text
┌─────────────────────────────────────┐
│                                     │
│                                     │
│                                     │
│                                     │
│             ┌───┐                   │
│             │ 1 │---o---o           │
│             └───┘       │           │
│                         o           │
│                                     │
│              ZIGLOOM                │
│                                     │
│          Offline logic puzzles      │
│                                     │
│              Loading                │
│                                     │
│                                     │
└─────────────────────────────────────┘
```

### Reduced Motion State

```text
┌─────────────────────────────────────┐
│                                     │
│                                     │
│                                     │
│                                     │
│             ┌───┐                   │
│             │ 1 │---o---o           │
│             └───┘       │           │
│                         o           │
│                                     │
│              ZIGLOOM                │
│                                     │
│          Offline logic puzzles      │
│                                     │
│              Loading                │
│                                     │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component      | Content                     | Behavior                                      |
| -------------- | --------------------------- | --------------------------------------------- |
| Logo mark      | Small path and clue motif   | May draw once during launch                   |
| Title          | `ZIGLOOM`                   | No action                                     |
| Subtitle       | `Offline logic puzzles`     | No action                                     |
| Loading status | `Loading` or empty visually | No action; should not expose technical steps  |

## Navigation

| Condition                         | Destination       |
| --------------------------------- | ----------------- |
| First-time player                 | Onboarding screen |
| Returning player                  | Home screen       |
| Local state fails to load cleanly  | Home screen       |

## State Rules

### First-Time Player

- Load preferences and puzzle metadata.
- Route to Onboarding when `hasCompletedOnboarding` is false.

### Returning Player

- Load preferences, progression, and any in-progress puzzle state.
- Route to Home when `hasCompletedOnboarding` is true.

### Local Load Error

- Fall back to default preferences.
- Keep bundled puzzle metadata available.
- Route to Home and allow play from Puzzle 1 if progress cannot be read.

## Data Needed

- `themeMode`
- `locale`
- `soundEnabled`
- `hapticsEnabled`
- `hasCompletedOnboarding`
- `progressionState`
- `inProgressPuzzleState`

## Acceptance Criteria

- Splash shows the Zigloom identity clearly.
- Splash only performs local setup.
- Splash routes first-time and returning players correctly.
- Splash respects reduced motion.
- Splash does not include login, account, ads, online sync, or social features.
