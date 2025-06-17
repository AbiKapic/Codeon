import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import '../../lib/src/features/authentication/presentation/login_screen.dart';
import '../helpers/test_app.dart';

void main() {
  group('LoginScreen', () {
    setUp(() {
      setupTestEnvironment();
    });

    testWidgets('should display welcome text', (WidgetTester tester) async {
      await pumpWidget(tester, const LoginScreen());

      expect(find.text('Welcome back!'), findsOneWidget);
      expect(find.text('Sign in to continue'), findsOneWidget);
    });

    testWidgets('should display email and password fields', (WidgetTester tester) async {
      await pumpWidget(tester, const LoginScreen());

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('should display login button', (WidgetTester tester) async {
      await pumpWidget(tester, const LoginScreen());

      // Find the login button specifically (not the app bar title)
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Login'), findsNWidgets(2)); // One in button, one in app bar
    });

    testWidgets('should display social login buttons', (WidgetTester tester) async {
      await pumpWidget(tester, const LoginScreen());

      expect(find.text('Google'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsNWidgets(2));
    });

    testWidgets('should display sign up link', (WidgetTester tester) async {
      await pumpWidget(tester, const LoginScreen());

      expect(find.text('Don\'t have an account?'), findsOneWidget);
      expect(find.text('Sign up'), findsOneWidget);
    });

    testWidgets('should toggle password visibility', (WidgetTester tester) async {
      await pumpWidget(tester, const LoginScreen());

      // Initially should show visibility off icon
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      // Tap visibility toggle
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      // Should now show visibility icon
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should validate email field', (WidgetTester tester) async {
      await pumpWidget(tester, const LoginScreen());

      // Find the login button specifically (not the app bar title)
      final loginButton = find.byType(ElevatedButton);

      // Try to submit with invalid email
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Please enter a valid email'), findsOneWidget);

      // Enter valid email
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Please enter a valid email'), findsNothing);
    });

    testWidgets('should validate password field', (WidgetTester tester) async {
      await pumpWidget(tester, const LoginScreen());

      // Find the login button specifically
      final loginButton = find.byType(ElevatedButton);

      // Enter valid email first
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');

      // Try to submit with empty password
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Please enter your password'), findsOneWidget);

      // Enter short password
      await tester.enterText(find.byType(TextFormField).last, '123');
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Password must be at least 6 characters'), findsOneWidget);

      // Enter valid password
      await tester.enterText(find.byType(TextFormField).last, '123456');
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Password must be at least 6 characters'), findsNothing);
    });

    testWidgets('should show loading state during login', (WidgetTester tester) async {
      await pumpWidget(tester, const LoginScreen());

      // Find the login button specifically
      final loginButton = find.byType(ElevatedButton);

      // Enter valid credentials
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, '123456');

      // Tap login button
      await tester.tap(loginButton);
      await tester.pump();

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should navigate to register when sign up is pressed', (WidgetTester tester) async {
      await pumpRouterWidget(tester, '/login');

      await tester.tap(find.text('Sign up'));
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('Register'), findsOneWidget);
    });

    testWidgets('should handle form submission with valid data', (WidgetTester tester) async {
      await pumpRouterWidget(tester, '/login');

      // Find the login button specifically
      final loginButton = find.byType(ElevatedButton);

      // Enter valid credentials
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, '123456');

      // Submit form
      await tester.tap(loginButton);
      await tester.pump();

      // Should show loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for the simulated API call
      await tester.pump(const Duration(seconds: 3));

      // Should navigate to home after successful login
      expect(find.text('Home Screen'), findsOneWidget);
    });
  });
} 