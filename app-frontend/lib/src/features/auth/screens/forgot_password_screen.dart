// lib/src/features/auth/screens/forgot_password_screen.dart
// (Paste the code from the previous 'forgot_password_screen.dart' response here)
import 'package:al_faruk_app/src/features/auth/screens/otp_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Enter the email associated with your account and we\'ll send an email with instructions to reset your password.'),
            const SizedBox(height: 30),
            const TextField(decoration: InputDecoration(labelText: 'Email Address'), keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OTPScreen())), child: const Text('Send OTP')),
          ],
        ),
      ),
    );
  }
}