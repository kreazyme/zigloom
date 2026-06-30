# AGENT.md

Guidelines for agents working in this repository.

## Project Shape

This is a Flutter app scaffold for Zigloom, a LinkedIn Zip-inspired puzzle game.

Key source locations:

- `lib/main.dart`: app entry, localization provider, router host, theme selection.
- `lib/common/app_router.dart`: route constants and `go_router` setup.
- `lib/common/theme.dart`: global light/dark themes and app design tokens.
- `lib/pages/`: screen-level UI grouped by feature/page.
- `lib/providers/`: Riverpod providers for app-wide state.
- `lib/helper/`: reusable platform/storage/dialog helpers.
- `assets/i18n/`: source localization JSON for `slang`.
- `lib/gen/i18n/`: generated localization code.
- `docs/`: project notes and generated documentation.

## Development Principles

- Prefer small, focused changes that fit the current folder structure.
- Keep game rules and puzzle validation separate from UI widgets.
- Use Riverpod for new state management.
- Use `go_router` for navigation and keep route paths in `AppRoutePaths`.
- Use generated `slang` translations for user-visible strings.
- Keep legal, onboarding, settings, and gameplay concerns separated.
- Do not copy LinkedIn branding, assets, or proprietary puzzle data.

## App Flow

Expected flow:

1. `SplashPage` loads local state and routes the user.
2. New users visit `OnboardingPage`.
3. Returning users land on `HomePage`.
4. `HomePage` hosts the daily puzzle experience.
5. Settings/legal surfaces are reachable outside the main board flow.

When adding routes:

- Add the path to `AppRoutePaths`.
- Add the `GoRoute` in `appRouter`.
- Keep page widgets in `lib/pages/<feature>/<feature>_page.dart`.

## App Architecture

Keep the implementation simple and close to the current scaffold:

- Put screens in `lib/pages/<feature>/<feature>_page.dart`.
- Put reusable widgets near the page that owns them, or in `lib/common/widgets/` when shared.
- Put Riverpod providers in `lib/providers/`.
- Keep simple puzzle models/helpers near the provider or page that uses them.
- Avoid creating clean architecture folders such as `domain`, `application`, or `presentation`.
- Avoid creating a dedicated `zip` feature folder unless the app grows enough to clearly need it.

The default shape is provider plus UI. Providers own state and actions; pages/widgets render that state and call provider actions.

## Global Style

- Define reusable colors, typography, spacing, and shape values in `lib/common/theme.dart` or nearby theme extensions.
- Keep the game board visually centered and responsive.
- Use stable board sizing with aspect ratios or constraints so cells do not shift during interaction.
- Prefer icon buttons for reset, undo, hint, settings, and share.
- Keep card radius at `8.0` or less unless a specific component requires otherwise.
- Support light and dark modes from the start.
- Use clear color states for empty, selected path, numbered clue, invalid, and solved cells.
- Avoid one-color interfaces; the board, path, clues, and controls should be distinguishable.

## Flutter Conventions

- Prefer `const` constructors where possible.
- Keep widgets small when build methods become hard to scan.
- Name files with `snake_case.dart`.
- Name classes with clear feature nouns, such as `ZipBoard`, `ZipCellView`, or `PuzzleValidator`.
- Avoid placing domain logic inside `build` methods.
- Avoid long anonymous callbacks when a named private method improves readability.
- Keep comments sparse and useful.

## State Management

- Prefer `flutter_riverpod` imports for new code.
- Use providers for app state, puzzle state, timers, local data access, and settings.
- Keep mutable game interactions in a notifier/controller rather than directly in widgets.
- Read persistent state through helper/provider layers instead of calling `SharedPreferences` from UI.

## Localization

- Add English strings to `assets/i18n/locale_en.json`.
- Add Vietnamese strings to `assets/i18n/locale_vi.json`.
- Regenerate `slang` outputs after changing locale JSON.
- Do not hard-code user-facing text in widgets unless it is temporary debugging text.

## Verification

Do not add tests unless the user explicitly asks for them.

Run the relevant checks before handing off when practical:

- `fvm dart format .`
- `fvm flutter analyze`

## Documentation

- Keep `feature.md` updated when product scope changes.
- Add implementation notes to `docs/` when decisions affect future development.
- Update this file when conventions change.

## Agent Workflow

- Inspect existing code before editing.
- Preserve unrelated user changes.
- Use `apply_patch` for manual file edits.
- Keep generated files generated; do not hand-edit `lib/gen/i18n/`.
- Mention any commands that could not be run.
