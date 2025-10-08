// lib/src/features/notifications/screens/notification_center_screen.dart
import 'dart:ui'; // <-- 1. IMPORT for the BackdropFilter
import 'package:al_faruk_app/src/features/notifications/models/notification_model.dart';
// import 'package:al_faruk_app/src/features/notifications/screens/notification_detail_screen.dart'; // No longer needed
import 'package:al_faruk_app/src/features/notifications/widgets/notification_list_item.dart';
import 'package:flutter/material.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() => _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  // --- Mock Data ---
  final List<AppNotification> _notifications = [
    AppNotification(id: '1', title: 'New Video: The Beauty of Mecca', body: 'A new documentary has been released exploring the spiritual and historical significance of Mecca. Tap to watch now.', type: NotificationType.video, timestamp: DateTime.now().subtract(const Duration(hours: 2)), isRead: false),
    AppNotification(id: '2', title: 'Welcome to AL FARUK!', body: 'Thank you for joining our community. Explore our collection of inspiring content.', type: NotificationType.general, timestamp: DateTime.now().subtract(const Duration(days: 3)), isRead: true),
  ];
  // --- End Mock Data ---

  // --- 2. CREATE THE NEW DIALOG METHOD ---
  Future<void> _showNotificationDetailDialog(AppNotification notification) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible allows closing the dialog by tapping outside of it
      barrierDismissible: true,
      builder: (BuildContext context) {
        // Use BackdropFilter for the blur effect
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            title: Text(notification.title),
            content: SingleChildScrollView(
              child: Text(notification.body),
            ),
            actions: <Widget>[
              // Only show the "Watch Now" button for video notifications
              if (notification.type == NotificationType.video)
                TextButton(
                  child: const Text('Watch Now'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    // TODO: Navigate to the actual video player
                  },
                ),
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: _notifications.isEmpty
          ? const Center( /* ... Empty State UI remains the same ... */ )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return NotificationListItem(
                  notification: notification,
                  // --- 3. UPDATE THE onTap LOGIC ---
                  onTap: () {
                    setState(() {
                      notification.isRead = true;
                    });
                    // Call our new dialog function instead of navigating
                    _showNotificationDetailDialog(notification);
                  },
                );
              },
            ),
    );
  }
}