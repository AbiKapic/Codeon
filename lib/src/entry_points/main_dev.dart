import 'package:flutter/material.dart';
import '../core/environment/environment.dart';
import '../main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  EnvironmentConfig(
    environment: Environment.dev,
    name: 'Development',
    appName: 'Codeon Dev',
    appIcon: 'assets/codeon_icon.png',
    baseUrl: 'https://dev-api.codeon.com',
  );
  
  await initializeApp();
  runApp(const MyApp());
} 