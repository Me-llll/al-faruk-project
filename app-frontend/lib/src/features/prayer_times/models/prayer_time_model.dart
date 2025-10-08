// lib/src/features/prayer_times/models/prayer_time_model.dart
import 'package:flutter/material.dart';

class PrayerTime {
  final String name;
  final String time;
  final IconData icon;
  bool isReminderOn;

  PrayerTime({
    required this.name,
    required this.time,
    required this.icon,
    this.isReminderOn = true,
  });
}