// lib/src/features/auth/screens/otp_screen.dart
// (Paste the code from the previous 'otp_screen.dart' response here)
import 'package:al_faruk_app/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56, height: 56,
      textStyle: const TextStyle(fontSize: 20, color: AppTheme.primaryColor, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(border: Border.all(color: AppTheme.hintColor.withOpacity(0.5)), borderRadius: BorderRadius.circular(8)),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Enter the 6-digit code sent to your email.', textAlign: TextAlign.center),
              const SizedBox(height: 40),
              Pinput(length: 6, defaultPinTheme: defaultPinTheme, focusedPinTheme: defaultPinTheme.copyDecorationWith(border: Border.all(color: AppTheme.primaryColor))),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: () {}, child: const Text('Verify')),
              const SizedBox(height: 20),
              TextButton(onPressed: () {}, child: const Text("Didn't receive code? Resend"))
            ],
          ),
        ),
      ),
    );
  }
}