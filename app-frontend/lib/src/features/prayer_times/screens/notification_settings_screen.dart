// lib/src/features/prayer_times/screens/notification_settings_screen.dart
import 'package:al_faruk_app/src/core/services/settings_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the settings service. We listen for changes to update the UI.
    final settings = Provider.of<SettingsService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Reminder Settings')),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Enable All Reminders', style: TextStyle(fontWeight: FontWeight.bold)),
            value: settings.remindersEnabled,
            onChanged: (value) => settings.setRemindersEnabled(value),
          ),
          const Divider(),
          if (settings.remindersEnabled) ...[
            const ListTile(
              title: Text('Notification Behavior', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SwitchListTile(
              title: const Text('Reminder Sound'),
              value: settings.soundEnabled,
              onChanged: (value) => settings.setSoundEnabled(value),
            ),
            
            // --- THE FIX: REPLACE ListTile WITH A DROPDOWN ---
            if (settings.soundEnabled)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Sound',
                    border: OutlineInputBorder(),
                  ),
                  value: settings.selectedSound,
                  items: settings.soundOptions.entries.map((entry) {
                    // entry.key is 'adhan.mp3', entry.value is 'Adhan'
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      // Update the setting in the service
                      settings.setSelectedSound(newValue);
                      // Play a preview of the new sound
                      _audioPlayer.play(AssetSource('audio/$newValue'));
                    }
                  },
                ),
              ),

            SwitchListTile(
              title: const Text('Vibration'),
              value: settings.vibrationEnabled,
              onChanged: (value) => settings.setVibrationEnabled(value),
            ),
          ]
        ],
      ),
    );
  }
}