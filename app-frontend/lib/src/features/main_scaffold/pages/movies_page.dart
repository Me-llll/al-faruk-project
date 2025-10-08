// lib/src/features/main_scaffold/pages/movies_page.dart
import 'package:flutter/material.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Movies Page (Paid)',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}