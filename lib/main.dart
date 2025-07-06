import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracer_app/providers/auth_provider.dart'; // ✅ Auth Provider
import 'package:mood_tracer_app/providers/mood_provider.dart'; // Mood Provider
import 'package:mood_tracer_app/providers/theme_provider.dart'; // Theme Provider
import 'package:mood_tracer_app/utils/app_themes.dart'; // Theme Style
import 'package:mood_tracer_app/utils/router.dart'; // App Router
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MoodProvider()),
        ChangeNotifierProvider(
            create: (_) => AuthProvider()), // ✅ Tambahan: Auth
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final router = AppRouter(context.watch<AuthProvider>()).router;

          return MaterialApp.router(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            title: 'Mood Tracker',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
