import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  static const String _markdownContent = '''
# Terms of Service

**Last updated: February 18, 2026**

## Agreement to Terms

By accessing and using Example Template ("the App"), you agree to be bound by these Terms of Service. If you disagree with any part of these terms, you may not access the App.

## Use License

### Grant of License
We grant you a revocable, non-exclusive, non-transferable, limited license to:
- Download and install the App
- Use the App for your personal, non-commercial purposes
- Access the App's features and services

### Restrictions
You agree not to:
- Modify or copy the materials
- Use the materials for commercial purposes
- Attempt to reverse engineer any software in the App
- Remove any copyright or proprietary notations
- Transfer the materials to another person
- Use the App in any unlawful manner

## User Accounts

### Account Creation
To use certain features, you may need to create an account. You agree to:
- Provide accurate and complete information
- Maintain the security of your account
- Notify us immediately of any unauthorized access
- Accept responsibility for all activities under your account

### Account Termination
We reserve the right to terminate or suspend your account at our discretion, without notice, for conduct that we believe violates these Terms or is harmful to other users.

## User Content

### Your Responsibilities
You are responsible for any content you submit through the App. You represent that:
- You own or have the necessary rights to the content
- Your content does not violate any third-party rights
- Your content does not contain illegal or harmful material

### Content License
By posting content, you grant us a worldwide, non-exclusive, royalty-free license to use, modify, and display that content in connection with the App.

## Intellectual Property

The App and its original content, features, and functionality are owned by Example Template and are protected by international copyright, trademark, and other intellectual property laws.

## Prohibited Activities

You may not:
- Harass, abuse, or harm other users
- Spam or send unsolicited messages
- Spread viruses or malicious code
- Collect user information without consent
- Impersonate others
- Interfere with the App's operation
- Violate any applicable laws or regulations

## Disclaimers

### "As Is" Basis
The App is provided on an "AS IS" and "AS AVAILABLE" basis without any warranties of any kind, either express or implied.

### No Warranty
We do not warrant that:
- The App will be uninterrupted or error-free
- Defects will be corrected
- The App is free of viruses or harmful components
- Results from using the App will be accurate or reliable

## Limitation of Liability

In no event shall Example Template, its directors, employees, or agents be liable for any indirect, incidental, special, consequential, or punitive damages arising out of your use of the App.

### Maximum Liability
Our total liability to you for all claims shall not exceed the amount you paid to us in the past twelve months, or \$100, whichever is greater.

## Indemnification

You agree to defend, indemnify, and hold harmless Example Template from any claims, damages, losses, liabilities, and expenses arising from:
- Your use of the App
- Your violation of these Terms
- Your violation of any third-party rights

## Changes to Terms

We reserve the right to modify these Terms at any time. We will notify users of any material changes by:
- Posting the new Terms on the App
- Sending an email notification
- Displaying a notice within the App

Your continued use of the App after changes constitutes acceptance of the new Terms.

## Governing Law

These Terms shall be governed by and construed in accordance with the laws of the jurisdiction in which Example Template operates, without regard to its conflict of law provisions.

## Dispute Resolution

### Informal Resolution
Before filing a claim, you agree to contact us and attempt to resolve the dispute informally.

### Arbitration
Any disputes that cannot be resolved informally shall be resolved through binding arbitration, except where prohibited by law.

## Severability

If any provision of these Terms is found to be unenforceable, the remaining provisions will continue in full force and effect.

## Entire Agreement

These Terms constitute the entire agreement between you and Example Template regarding the use of the App.

## Contact Information

For questions about these Terms of Service, please contact us:
- Email: legal@example.com
- Website: https://example.com/contact
- Address: 123 Example Street, City, State, ZIP

## Acknowledgment

By using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.

---

© 2026 Example Template. All rights reserved.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service'), elevation: 0),
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
