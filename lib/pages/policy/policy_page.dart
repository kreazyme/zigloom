import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  static const String _markdownContent = '''
# Privacy Policy

**Last updated: February 18, 2026**

## Introduction

Welcome to Example Template. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you about how we look after your personal data and tell you about your privacy rights.

## Information We Collect

### Personal Information
We may collect the following types of personal information:
- Name and contact information
- Email address
- Usage data and analytics
- Device information

### Automatically Collected Information
When you use our application, we automatically collect:
- Log data
- Device identifiers
- Location data (with your permission)
- App usage statistics

## How We Use Your Information

We use the information we collect to:
- Provide and maintain our service
- Notify you about changes to our service
- Provide customer support
- Monitor the usage of our service
- Detect, prevent and address technical issues
- Improve user experience

## Data Storage and Security

We implement appropriate technical and organizational security measures to protect your personal data. Your data is stored securely using industry-standard encryption protocols.

### Data Retention
We will retain your personal data only for as long as necessary for the purposes set out in this Privacy Policy.

## Your Rights

You have the right to:
- Access your personal data
- Correct inaccurate data
- Request deletion of your data
- Object to processing of your data
- Request data portability
- Withdraw consent

## Third-Party Services

Our application may contain links to third-party services. We are not responsible for the privacy practices of these third parties.

## Children's Privacy

Our service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13.

## Changes to This Privacy Policy

We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.

## Contact Us

If you have any questions about this Privacy Policy, please contact us:
- By email: privacy@example.com
- By visiting our website: https://example.com/contact

---

© 2026 Example Template. All rights reserved.
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
