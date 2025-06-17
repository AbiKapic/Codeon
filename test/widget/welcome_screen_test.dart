import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import '../../lib/src/features/home/presentation/welcome_screen.dart';
import '../helpers/test_app.dart';

void main() {
  group('WelcomeScreen', () {
    setUp(() {
      setupTestEnvironment();
    });

    testWidgets('should display app name and subtitle', (WidgetTester tester) async {
      await pumpWidget(tester, const WelcomeScreen());

      expect(find.text('Codeon'), findsOneWidget);
      expect(find.text('Your coding companion'), findsOneWidget);
    });

    testWidgets('should display app icon', (WidgetTester tester) async {
      await pumpWidget(tester, const WelcomeScreen());

      expect(find.byIcon(Icons.code), findsOneWidget);
    });

    testWidgets('should display Get Started button', (WidgetTester tester) async {
      await pumpWidget(tester, const WelcomeScreen());

      expect(find.text('Get Started'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should display Sign up link', (WidgetTester tester) async {
      await pumpWidget(tester, const WelcomeScreen());

      expect(find.text('Don\'t have an account? Sign up'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('should navigate to login when Get Started is pressed', (WidgetTester tester) async {
      await pumpRouterWidget(tester, '/welcome');

      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('Welcome back!'), findsOneWidget);
    });

    testWidgets('should navigate to register when Sign up is pressed', (WidgetTester tester) async {
      await pumpRouterWidget(tester, '/welcome');

      await tester.tap(find.text('Don\'t have an account? Sign up'));
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('Register'), findsOneWidget);
    });

    testWidgets('should have proper styling', (WidgetTester tester) async {
      await pumpWidget(tester, const WelcomeScreen());

      // Check if the main container has the correct background color
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, const Color(0xFFF5F5F5));

      // Check if the Get Started button has the correct styling
      final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final buttonStyle = elevatedButton.style as ButtonStyle?;
      
      // Note: In a real test, you might want to check specific style properties
      expect(buttonStyle, isNotNull);
    });

    testWidgets('should be responsive to different screen sizes', (WidgetTester tester) async {
      // Test on a small screen
      tester.binding.window.physicalSizeTestValue = const Size(320, 568);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await pumpWidget(tester, const WelcomeScreen());
      await tester.pumpAndSettle();

      expect(find.text('Codeon'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);

      // Test on a large screen
      tester.binding.window.physicalSizeTestValue = const Size(1024, 768);
      await pumpWidget(tester, const WelcomeScreen());
      await tester.pumpAndSettle();

      expect(find.text('Codeon'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);

      // Reset the window size
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });
  });
} 