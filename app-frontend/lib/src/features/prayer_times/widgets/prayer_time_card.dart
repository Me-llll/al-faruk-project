// lib/src/features/prayer_times/widgets/prayer_time_card.dart
import 'package:al_faruk_app/src/features/prayer_times/models/prayer_time_model.dart';
import 'package:flutter/material.dart';

// Converted to a StatelessWidget for simplicity
class PrayerTimeCard extends StatelessWidget {
  final PrayerTime prayerTime;
  final bool isNextPrayer;

  const PrayerTimeCard({
    super.key,
    required this.prayerTime,
    this.isNextPrayer = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHighlighted = isNextPrayer;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: isHighlighted ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isHighlighted
            ? BorderSide(color: colorScheme.secondary, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Increased vertical padding
        child: Row(
          children: [
            Icon(prayerTime.icon,
                color: isHighlighted ? colorScheme.secondary : null),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                prayerTime.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isHighlighted ? colorScheme.secondary : null,
                ),
              ),
            ),
            Text(
              prayerTime.time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isHighlighted ? colorScheme.secondary : null,
              ),
            ),
            // The Switch has been removed
          ],
        ),
      ),
    );
  }
}