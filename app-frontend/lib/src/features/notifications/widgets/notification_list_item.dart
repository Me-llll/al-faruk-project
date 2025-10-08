// lib/src/features/notifications/widgets/notification_list_item.dart
import 'package:al_faruk_app/src/features/notifications/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationListItem extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const NotificationListItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.video:
        return Icons.play_circle_outline;
      case NotificationType.promotion:
        return Icons.campaign_outlined;
      default:
        return Icons.notifications_none_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;
    final timeAgo = DateFormat.yMMMd().add_jm().format(notification.timestamp);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: isUnread ? Theme.of(context).colorScheme.secondary.withOpacity(0.05) : null,
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          alignment: Alignment.topRight,
          children: [
            Icon(_getIconForType(notification.type), size: 30),
            if (isUnread)
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
              )
          ],
        ),
        title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(timeAgo, style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}