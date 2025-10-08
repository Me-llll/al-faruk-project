// lib/src/features/main_scaffold/screens/main_screen.dart
import 'package:al_faruk_app/src/features/main_scaffold/pages/audio_page.dart';
import 'package:al_faruk_app/src/features/main_scaffold/pages/home_page.dart';
import 'package:al_faruk_app/src/features/main_scaffold/pages/movies_page.dart';
import 'package:al_faruk_app/src/features/main_scaffold/pages/qiblah_page.dart';
import 'package:al_faruk_app/src/features/main_scaffold/pages/videos_page.dart';
import 'package:al_faruk_app/src/features/main_scaffold/widgets/custom_app_bar.dart';
import 'package:al_faruk_app/src/features/main_scaffold/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // THE FIX IS HERE: Changed 'static const' to 'static final'.
  // Also remove 'const' from the list items that are no longer const.
  static final List<Widget> _pages = <Widget>[
    const HomePage(), // HomePage can still be const
    VideosPage(),     // VideosPage is now non-const
    const AudioPage(),
    const MoviesPage(),
    const QiblahPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}