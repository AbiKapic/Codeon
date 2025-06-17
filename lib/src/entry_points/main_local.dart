import 'package:flutter/material.dart';
import '../core/environment/environment.dart';
import '../main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  EnvironmentConfig(
    environment: Environment.local,
    name: 'Local',
    appName: 'Codeon Local',
    appIcon: 'assets/codeon_icon.png',
    baseUrl: 'http://localhost:3000',
  );
  
  await initializeApp();
  runApp(const MyApp());
} 