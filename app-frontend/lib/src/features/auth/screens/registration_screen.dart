// lib/src/features/auth/screens/registration_screen.dart
// (Paste the code from the previous 'registration_screen.dart' response here)
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _agreeToTerms = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(decoration: const InputDecoration(labelText: 'Full Name'), validator: (v) => v!.isEmpty ? 'Please enter your name' : null),
              const SizedBox(height: 20),
              TextFormField(decoration: const InputDecoration(labelText: 'Email Address'), keyboardType: TextInputType.emailAddress, validator: (v) => v!.isEmpty || !v.contains('@') ? 'Enter a valid email' : null),
              const SizedBox(height: 20),
              TextFormField(decoration: const InputDecoration(labelText: 'Phone Number'), keyboardType: TextInputType.phone, validator: (v) => v!.isEmpty ? 'Enter your phone number' : null),
              const SizedBox(height: 20),
              TextFormField(decoration: const InputDecoration(labelText: 'Password'), obscureText: true, validator: (v) => v!.length < 6 ? 'Password must be at least 6 characters' : null),
              const SizedBox(height: 20),
              Row(children: [ Checkbox(value: _agreeToTerms, onChanged: (value) => setState(() => _agreeToTerms = value!)), const Expanded(child: Text('I agree to the Terms of Service & Privacy Policy.'))]),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: () { if (_formKey.currentState!.validate() && _agreeToTerms) {} }, child: const Text('Sign Up')),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [ const Text("Already have an account?"), TextButton(onPressed: () => Navigator.pop(context), child: const Text('Log In'))]),
            ],
          ),
        ),
      ),
    );
  }
}