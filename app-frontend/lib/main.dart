// lib/main.dart
import 'package:al_faruk_app/src/core/services/settings_service.dart';
import 'package:al_faruk_app/src/core/theme/app_theme.dart';
import 'package:al_faruk_app/src/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:al_faruk_app/generated/app_localizations.dart';
import 'package:al_faruk_app/localization/afaan_oromo_localizations.dart'; // Add this import

final themeManager = ThemeManager();
final settingsService = SettingsService();
final Future<void> appInitialization = _initializeApp();

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    dotenv.load(fileName: ".env"),
    settingsService.loadSettings(),
  ]);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    themeManager.addListener(() {
      if (mounted) setState(() {});
    });
    settingsService.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    themeManager.removeListener(() {});
    settingsService.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator())));
        }
        if (snapshot.hasError) {
          return MaterialApp(home: Scaffold(body: Center(child: Text('Failed to initialize app: ${snapshot.error}'))));
        }
        return ChangeNotifierProvider.value(
          value: settingsService,
          child: MaterialApp(
            title: 'AL FARUK',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeManager.themeMode,

            locale: settingsService.currentLocale,

            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AfaanOromoLocalizationsDelegate(), // Add this line
            ],

            supportedLocales: const [
              Locale('en'), // English
              Locale('am'), // Amharic
              Locale('om'), // Afaan Oromo
            ],

            home: const LoginScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}