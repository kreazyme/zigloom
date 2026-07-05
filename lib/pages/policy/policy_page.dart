import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  static const String _markdownContent = '''
# Privacy Policy

**Effective date: July 5, 2026**

## Overview

Zigloom is an offline logic puzzle game. The app is designed to work without an account, without online leaderboards, without advertising, and without analytics.

This Privacy Policy explains what data Zigloom stores locally on your device and how that data is used.

## Data Stored on This Device

Zigloom stores gameplay progress and preferences locally so the app can remember your play state. This may include:
- Onboarding completion
- Solved puzzle numbers
- In-progress puzzle paths
- Elapsed time, move counts, and undo counts for in-progress puzzles
- Current streak, best streak, and last played date
- Theme, language, sound, and haptics preferences

This data is stored on your device using the platform's local app storage.

## Notifications and Time Zone

Zigloom may ask for permission to send a daily play reminder. If you allow notifications, the app uses your device's local time zone to schedule the reminder at the right local time.

Notification permission and scheduling are handled by your device operating system. You can change notification permissions in your device settings.

## Data We Do Not Collect

Zigloom does not currently collect:
- Names, email addresses, or account information
- Payment information
- Advertising identifiers
- Location data
- Analytics events
- User-generated content
- Puzzle progress on a server

## Sharing

Because Zigloom stores progress locally and does not use accounts, analytics, ads, or online leaderboards, we do not sell, rent, or share your personal data with third parties.

## Data Deletion

You can delete Zigloom's local data by deleting the app or clearing the app's data through your device settings. This may remove puzzle progress, streaks, in-progress paths, and preferences.

## Children's Privacy

Zigloom is a general puzzle game and does not knowingly collect personal information from children.

## Changes to This Policy

We may update this Privacy Policy in a future app release. The updated policy will be shown in the app with a new effective date.

## Contact

If you have questions about this Privacy Policy, please contact us at email: spoon.me.dev@gmail.com

---

© 2026 Zigloom. All rights reserved.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy'), elevation: 0),
      body: Markdown(
        data: _markdownContent,
        selectable: true,
        styleSheet: MarkdownStyleSheet(
          h1: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          h2: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          h3: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          p: Theme.of(context).textTheme.bodyMedium,
          listBullet: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
