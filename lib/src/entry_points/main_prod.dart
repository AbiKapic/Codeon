import 'package:flutter/material.dart';
import '../core/environment/environment.dart';
import '../main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  EnvironmentConfig(
    environment: Environment.prod,
    name: 'Production',
    appName: 'Codeon',
    appIcon: 'assets/codeon_icon.png',
    baseUrl: 'https://api.codeon.com',
  );
  
  await initializeApp();
  runApp(const MyApp());
} 