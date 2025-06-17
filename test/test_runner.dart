import 'package:flutter_test/flutter_test.dart';

import 'unit/environment_test.dart' as environment_test;
import 'widget/welcome_screen_test.dart' as welcome_screen_test;
import 'widget/login_screen_test.dart' as login_screen_test;

void main() {
  group('All Tests', () {
    group('Unit Tests', () {
      environment_test.main();
    });

    group('Widget Tests', () {
      welcome_screen_test.main();
      login_screen_test.main();
    });
  });
} 