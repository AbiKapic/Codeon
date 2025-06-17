import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/environment/environment.dart';
import 'core/di/injection.dart';
import 'core/routing/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: EnvironmentConfig.instance.appName,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF2196F3), // Blue
          surface: Colors.white,
          background: const Color(0xFFF5F5F5), // Light grey
          onPrimary: Colors.white,
          onSurface: Colors.black87,
          onBackground: Colors.black87,
        ),
      ),
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('es', ''), // Spanish
        Locale('fr', ''), // French
        // Add more locales as needed
      ],
    );
  }
}

// Initialize dependencies
Future<void> initializeApp() async {
  await configureDependencies();
} 