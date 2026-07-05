import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  static const String _markdownContent = '''
# Terms

**Effective date: July 5, 2026**

## About Zigloom

Zigloom is an offline logic puzzle game. The app lets you play bundled puzzles, draw a continuous path through each board, track local progress, and adjust local settings such as theme, language, sound, and haptics.

By using Zigloom, you agree to these Terms. If you do not agree, please do not use the app.

## Personal Use

You may use Zigloom for personal, non-commercial play. You may not:
- Copy, resell, redistribute, or commercially exploit the app or its puzzle content
- Remove ownership notices from the app
- Attempt to disrupt, damage, or misuse the app
- Use the app in a way that violates applicable law

## Offline Play and Local Progress

Zigloom does not require an account and does not provide online community features, purchases, subscriptions, or leaderboards.

Puzzle progress and settings are stored locally on your device. This may include solved puzzles, in-progress puzzle paths, elapsed time, move counts, undo counts, play streak information, onboarding status, theme, language, sound, and haptics preferences.

Deleting the app or clearing app data may remove this local progress and these settings.

## Notifications

Zigloom may ask for permission to send a daily play reminder. You can allow or deny notifications through your device settings. Notifications are used only to remind you to play and keep your streak going.

## Intellectual Property

Zigloom, including its design, code, artwork, and bundled puzzle content, is protected by intellectual property laws. These Terms do not transfer ownership of Zigloom or its content to you.

## No Warranty

Zigloom is provided "as is" and "as available." We do not promise that the app will always be available, uninterrupted, error-free, or compatible with every device or operating system version.

## Limitation of Liability

To the fullest extent permitted by law, we are not liable for indirect, incidental, special, consequential, or punitive damages arising from your use of Zigloom, including loss of local progress or settings.

## Changes to These Terms

We may update these Terms in a future app release. The updated Terms will be shown in the app with a new effective date. Your continued use of Zigloom after an update means you accept the updated Terms.

## Contact

If you have questions about these Terms, please contact us at email: spoon.me.dev@gmail.com

---

© 2026 Zigloom. All rights reserved.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms'), elevation: 0),
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
