# Privacy Policy Screen

## Purpose

The Privacy Policy screen provides app-store-ready privacy information while keeping gameplay uncluttered.

The policy should clearly state that Zigloom is offline and stores progress locally on the device.

## Screen Content

- Back button.
- Title: `Privacy Policy`.
- Effective date.
- Plain-language privacy sections.
- Local data deletion note.

Do not include account data, server processing, advertising identifiers, analytics, or third-party sharing unless those features are actually added.

## UI Mockups

### Default State

```text
┌─────────────────────────────────────┐
│ [ Back ]          Privacy Policy    │
│                                     │
│ Effective date: TBD                 │
│                                     │
│ Zigloom works offline. The app      │
│ stores puzzle progress and settings │
│ on this device.                     │
│                                     │
│ Data stored locally                 │
│ - Solved puzzles                    │
│ - Best times and moves              │
│ - In-progress puzzle path           │
│ - Theme, language, sound, haptics   │
│                                     │
│ Data deletion                       │
│ Delete the app or clear app data to │
│ remove local progress and settings. │
│                                     │
│ Contact                             │
│ TBD                                 │
│                                     │
└─────────────────────────────────────┘
```

## Component Behavior

| Component      | Content                    | Behavior                  |
| -------------- | -------------------------- | ------------------------- |
| Back button    | Icon button or `Back`      | Returns to previous screen |
| Title          | `Privacy Policy`           | No action                 |
| Policy content | Local privacy copy         | Scrolls if needed         |
| Contact        | Contact placeholder or link | Opens mail client only if configured |

## Navigation

| Action      | Destination     |
| ----------- | --------------- |
| Tap `Back`  | Previous screen |

## State Rules

### Standard

- Show privacy copy in the selected locale.
- Keep content readable on small screens with vertical scrolling.

### Contact Not Configured

- Show `TBD` or omit the contact row until app-store metadata is ready.

## Data Needed

- `locale`
- `privacyPolicyEffectiveDate`
- `supportContact`

## Acceptance Criteria

- Privacy Policy is separate from gameplay.
- Privacy Policy states that gameplay is offline.
- Privacy Policy states that progress and settings are stored locally.
- Privacy Policy includes a local data deletion note.
- Privacy Policy is reachable from Home, Onboarding, and Settings.
