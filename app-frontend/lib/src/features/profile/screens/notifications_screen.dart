// lib/src/features/profile/screens/notifications_screen.dart
import 'package:al_faruk_app/src/features/prayer_times/models/prayer_time_model.dart';
import 'package:al_faruk_app/src/features/prayer_times/screens/notification_settings_screen.dart';
import 'package:al_faruk_app/src/features/prayer_times/widgets/prayer_time_card.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // For location
import 'package:adhan/adhan.dart'; // For prayer time calculation
import 'package:intl/intl.dart'; // For time formatting

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // We will store the future that gets prayer times
  late Future<PrayerTimes> _prayerTimesFuture;

  @override
  void initState() {
    super.initState();
    _prayerTimesFuture = _getPrayerTimes();
  }

  // --- Logic to get location and calculate prayer times ---
  Future<PrayerTimes> _getPrayerTimes() async {
    // 1. Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }
    
    // 2. Get current position
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // 3. Set up calculation parameters
    final myCoordinates = Coordinates(position.latitude, position.longitude);
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi; // Or Madhab.hanafi
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    return prayerTimes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Reminders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NotificationSettingsScreen(),
              ));
            },
          ),
        ],
      ),
      body: FutureBuilder<PrayerTimes>(
        future: _prayerTimesFuture,
        builder: (context, snapshot) {
          // --- 1. Handle loading state ---
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // --- 2. Handle error state ---
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // --- 3. Handle success state ---
          if (snapshot.hasData) {
            final prayerTimes = snapshot.data!;
            final formattedTime = DateFormat.jm(); // Use 'jm' for 5:30 PM format

            // Create a list of our custom PrayerTime model from the calculated data
            final prayerDataList = [
              PrayerTime(name: 'Fajr', time: formattedTime.format(prayerTimes.fajr), icon: Icons.brightness_4_outlined),
              PrayerTime(name: 'Sunrise', time: formattedTime.format(prayerTimes.sunrise), icon: Icons.wb_sunny_outlined),
              PrayerTime(name: 'Dhuhr', time: formattedTime.format(prayerTimes.dhuhr), icon: Icons.wb_sunny),
              PrayerTime(name: 'Asr', time: formattedTime.format(prayerTimes.asr), icon: Icons.brightness_6_outlined),
              PrayerTime(name: 'Maghrib', time: formattedTime.format(prayerTimes.maghrib), icon: Icons.brightness_5_outlined),
              PrayerTime(name: 'Isha', time: formattedTime.format(prayerTimes.isha), icon: Icons.nights_stay_outlined),
            ];

            // Determine the next prayer
            final nextPrayer = prayerTimes.nextPrayer();

            return ListView.builder(
              itemCount: prayerDataList.length,
              itemBuilder: (context, index) {
                final prayer = prayerDataList[index];
                // Highlight the card if its name matches the next prayer's name
                final bool isNext = prayer.name.toLowerCase() == nextPrayer.name.toLowerCase();
                return PrayerTimeCard(
                  prayerTime: prayer,
                  isNextPrayer: isNext,
                );
              },
            );
          }
          // Default state
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}