// lib/src/features/profile/screens/profile_screen.dart
import 'package:al_faruk_app/src/features/auth/screens/login_screen.dart';
import 'package:al_faruk_app/src/features/profile/screens/account_settings_screen.dart';
// --- THE FIX IS HERE: Correcting the file path ---
import 'package:al_faruk_app/src/features/profile/screens/notifications_screen.dart'; 
import 'package:al_faruk_app/src/features/profile/screens/app_settings_screen.dart';
import 'package:al_faruk_app/src/features/profile/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 24),
                const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
                const SizedBox(height: 16),
                const Text('User Name', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('user.name@email.com', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 24),
                const Divider(),
                SettingsListTile(
                  icon: Icons.person_outline,
                  title: 'Account Settings',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AccountSettingsScreen(),
                    ));
                  },
                ),
                SettingsListTile(
                  icon: Icons.notifications_none_outlined,
                  title: 'Prayer Reminders',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(),
                    ));
                  },
                ),
                SettingsListTile(
                  icon: Icons.settings_outlined,
                  title: 'App Settings',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AppSettingsScreen(),
                    ));
                  },
                ),
              ],
            ),
          ),
          // --- Logout Button ---
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                onPressed: () => _showLogoutDialog(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}