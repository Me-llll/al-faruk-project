// lib/src/features/main_scaffold/pages/audio_page.dart
import 'package:flutter/material.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Audio Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}