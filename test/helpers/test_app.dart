import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import '../../lib/src/core/environment/environment.dart';
import '../../lib/src/core/routing/app_router.dart';

class TestApp extends StatelessWidget {
  final Widget child;
  final GoRouter? router;
  final ThemeData? theme;

  const TestApp({
    super.key,
    required this.child,
    this.router,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: child,
      theme: theme ?? _defaultTheme,
    );
  }

  static ThemeData get _defaultTheme => ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF2196F3),
      surface: Colors.white,
      background: const Color(0xFFF5F5F5),
      onPrimary: Colors.white,
      onSurface: Colors.black87,
      onBackground: Colors.black87,
    ),
  );
}

class RouterTestApp extends StatelessWidget {
  final String initialLocation;
  final GoRouter? router;

  const RouterTestApp({
    super.key,
    this.initialLocation = '/welcome',
    this.router,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router ?? AppRouter.router,
      theme: TestApp._defaultTheme,
    );
  }
}

// Helper function to set up environment for tests
void setupTestEnvironment() {
  EnvironmentConfig(
    environment: Environment.local,
    name: 'Test',
    appName: 'Codeon Test',
    appIcon: 'assets/codeon_icon.png',
    baseUrl: 'http://localhost:3000',
  );
}

// Helper function to pump widget with proper setup
Future<void> pumpWidget(
  WidgetTester tester,
  Widget widget, {
  ThemeData? theme,
}) async {
  await tester.pumpWidget(
    TestApp(
      child: widget,
      theme: theme,
    ),
  );
}

// Helper function to pump router widget
Future<void> pumpRouterWidget(
  WidgetTester tester,
  String initialLocation,
) async {
  await tester.pumpWidget(
    RouterTestApp(initialLocation: initialLocation),
  );
} 