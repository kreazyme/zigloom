# Zigloom Design Guidelines

## Required Reading

Read this file before coding any user-facing Zigloom UI.

These guidelines define Zigloom's app style: glossy, colorful, playful, and easy to read. Focus on reusable UI primitives such as buttons, tiles, typography, shadows, icons, and feedback states.

## Style Summary

Zigloom should feel like a polished casual puzzle game:

- Bright saturated colors.
- Glossy blue interactive surfaces.
- Chunky white text with blue shadow or outline.
- Rounded square level tiles and board cells.
- Yellow star rewards.
- Red circular navigation buttons.
- Clear pressed, locked, invalid, solved, and selected states.

Avoid flat enterprise UI, gray Material defaults, thin borders, muted palettes, and plain text-only controls.

## Color Tokens

Use these colors as the base token family. Small variations are allowed for gradients, highlights, bevels, and disabled states.

| Token | Hex | Use |
| --- | --- | --- |
| Blue highlight | `#3FD3FF` | Top gloss, inner highlights |
| Blue base | `#178FE6` | Primary buttons, level tiles, clue cells |
| Blue deep | `#0846A8` | Bottom bevels, pressed states, tile shadows |
| Ink blue | `#182C93` | Text outlines, deep text shadows |
| Cyan pale | `#BFEFFF` | Empty cells, disabled blue surfaces |
| White | `#FFFFFF` | Numbers, icons, primary text |
| Star yellow | `#FFD629` | Stars, solved rewards, success highlights |
| Star orange | `#F7A812` | Star shadows and bevels |
| Action red | `#F1351E` | Back, next, close, destructive confirmation |
| Action orange | `#FF7A21` | Red button gloss and warning highlights |
| Success green | `#43C96B` | Complete state accents when needed |

## Gradients

Use gradients to make controls feel tactile.

- Blue controls: `#3FD3FF` at the top, `#178FE6` through the middle, `#0846A8` at the bottom.
- Red controls: `#FF7A21` at the top, `#F1351E` through the middle, darker red at the bottom.
- Stars: `#FFF06A` top highlight, `#FFD629` body, `#F7A812` lower bevel.
- Disabled blue surfaces: desaturate the blue gradient and reduce contrast, but keep the shape readable.

Do not use flat fills for primary game controls unless the state is disabled.

## Shadows And Bevels

Glossy components should have layered depth:

- Outer shadow: deep blue or purple-blue, offset downward.
- Bottom bevel: darker blue strip or gradient edge.
- Top highlight: soft white or cyan highlight.
- Inner rim: thin light-blue stroke for active tiles.

Recommended shadows:

- Level tile: `0 5 0 #063A91` plus soft `0 7 10 rgba(24, 44, 147, 0.28)`.
- Primary button: `0 4 0 #063A91` plus soft blue shadow.
- Red circular button: `0 4 0 #B51E15` plus soft red shadow.
- Text: dark blue shadow offset down-right.

Pressed controls should move down by the shadow height and shorten or remove the hard shadow.

## Typography

Use rounded, heavy, playful type.

- Display text: bold, chunky, slightly cartoon-like. Prefer `Luckiest Guy`, `Baloo 2 ExtraBold`, `Fredoka One`, or a similar bundled font if added.
- Numbers: large white bold italic or playful display style.
- Body text: rounded readable sans such as `Nunito`, `Fredoka`, or the closest available Material font.
- Utility labels: bold, compact, high contrast.

Do not use thin weights, serif display type, condensed enterprise fonts, or tiny low-contrast labels.

## Text Treatment

Important title text should use a layered arcade treatment:

1. White or pale blue fill.
2. Dark blue outline.
3. Purple-blue drop shadow.
4. Optional small cyan or white top highlight.

Numbers inside tiles should use:

- White fill.
- Blue shadow.
- Slight italic or playful slant when the font supports it.
- Large size relative to the tile.

Button labels should be uppercase, white, bold, and centered.

## Shape And Radius

Use rounded toy-like geometry.

- Level tiles: rounded square, `12` to `16` radius.
- Board cells: `8` to `12` radius.
- Primary buttons: `14` to `18` radius.
- Icon buttons for navigation: perfect circles.
- Panels: `12` radius maximum unless intentionally styled like a large tile.

Avoid sharp corners for interactive controls.

## Buttons

### Primary Button

Use for `Play`, `Next Puzzle`, `Start Puzzle`, and similar main actions.

- Glossy blue gradient.
- White uppercase label.
- Thick blue bevel/shadow.
- Optional white inner highlight.
- Minimum height: `52`.

States:

- Default: bright blue, full shadow.
- Pressed: moves down, shorter shadow.
- Disabled: desaturated blue, no hard shadow, lower contrast.
- Focused: white or yellow outer ring.

### Secondary Button

Use for `How To Play`, `Replay`, `Settings`, and lower-priority actions.

- Blue glossy style with slightly smaller scale, or outlined glossy blue.
- White or ink-blue label depending on fill.
- Same pressed behavior as primary.

### Circular Action Button

Use for back, next, close, reset confirmation, and carousel arrows.

- Red glossy circle.
- White icon.
- White rim.
- Dark red bottom shadow.
- Minimum size: `48x48`.

Do not use text inside circular action buttons unless there is no recognizable icon.

## Level Tiles

Level tiles are glossy blue rounded squares.

Content:

- Large white puzzle number.
- Solved badge or star only when supported by data.
- Lock icon for locked puzzles.

States:

- Available: bright blue, white number, deep blue shadow.
- Current: brighter rim, subtle pulse, or small highlight.
- Solved: available tile plus solved mark or star.
- Locked: desaturated blue, white lock icon, no number if the number should be hidden.
- Pressed: downward movement and shorter shadow.

## Board Cells

Board cells should share the same visual language as level tiles while staying readable during play.

States:

- Empty: pale blue surface with light border.
- Clue: glossy blue tile with white number.
- Path: saturated blue or cyan fill with clear connection to adjacent path cells.
- Head: white rim, brighter glow, or subtle pulse.
- Invalid: red/orange flash and short shake.
- Complete: yellow sparkle, bright rim, or brief sheen.

Do not make clue numbers, path cells, or empty cells too similar.

## Stars And Rewards

Use stars as reward indicators only when the app has matching state.

- If only solved/unsolved exists, use one star or a solved badge.
- Use three stars only when there is real rating logic.
- Stars should be yellow with orange bevel and a small white shine.
- Stars can bounce briefly on completion.

## Icons

Icons should be simple, filled, and high contrast.

- Use white icons on glossy colored buttons.
- Add blue or red shadow when needed for readability.
- Prefer familiar icons for settings, undo, reset, pause, play, lock, back, and next.
- Provide semantic labels for icon-only buttons.

## Motion

Motion should be short, bouncy, and functional.

- Tile press: 80 to 120 ms downward movement.
- Invalid move: 150 to 220 ms shake or bump.
- Path draw: 80 to 140 ms segment reveal.
- Completion: 500 to 900 ms star burst or shimmer.
- Screen transitions: slide or pop.

Respect reduced motion by disabling pulses, bounce loops, and decorative bursts.

## Accessibility

- Keep text contrast high, especially white text over blue surfaces.
- Do not rely on color alone for locked, solved, invalid, selected, or current states.
- Keep touch targets at least `48x48`.
- Keep text inside buttons and tiles large enough to read on small screens.
- Use semantic labels for icon-only controls.

## Implementation Rules

- Define reusable design tokens in `lib/common/theme.dart` or a nearby theme extension before spreading constants through pages.
- Prefer reusable widgets for glossy buttons, level tiles, board cells, circular icon buttons, stars, and title text.
- Do not hard-code user-facing strings in widgets; use `slang` locale files.
- Before implementing a UI screen, compare it against this file and the relevant file in `screens/`.
- If a requested design conflicts with these guidelines, update this file first or explicitly note the exception in the implementation summary.
