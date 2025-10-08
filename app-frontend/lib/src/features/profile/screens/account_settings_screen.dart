// lib/src/features/profile/screens/account_settings_screen.dart
import 'package:al_faruk_app/src/features/profile/screens/change_password_screen.dart';
import 'package:al_faruk_app/src/features/profile/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: ListView(
        children: [
          SettingsListTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen(),
              ));
            },
          ),
          SettingsListTile(
            icon: Icons.credit_card,
            title: 'Manage Subscription',
            onTap: () { /* TODO: Navigate to Subscription Screen (Case 3) */ },
          ),
          const Divider(),
          SettingsListTile(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            color: Colors.red,
            onTap: () { /* TODO: Implement delete account flow */ },
          ),
        ],
      ),
    );
  }
}