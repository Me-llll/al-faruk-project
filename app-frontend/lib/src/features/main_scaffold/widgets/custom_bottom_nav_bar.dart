// lib/src/features/main_scaffold/widgets/custom_bottom_nav_bar.dart
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed, // Shows all labels
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.secondary, // Gold color for active icon
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      elevation: 4,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.video_library_outlined), label: 'Videos'),
        BottomNavigationBarItem(icon: Icon(Icons.headset_outlined), label: 'Audio'),
        BottomNavigationBarItem(icon: Icon(Icons.theaters_outlined), label: 'Movies'),
        BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Qiblah'),
      ],
    );
  }
}