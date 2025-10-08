// lib/src/features/profile/screens/privacy_policy_screen.dart
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for AL FARUK App',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Last updated: [Date]',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Text(
              'Your privacy is important to us. This privacy policy explains how we collect, use, and protect your information when you use the AL FARUK mobile application (the "App"). By using the App, you agree to the collection and use of information in accordance with this policy.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24),
            
          ],
        ),
      ),
    );
  }
}