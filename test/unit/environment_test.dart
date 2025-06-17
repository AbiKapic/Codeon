import 'package:flutter_test/flutter_test.dart';
import '../../lib/src/core/environment/environment.dart';

void main() {
  group('EnvironmentConfig', () {
    tearDown(() {
      // Reset the singleton instance after each test
      EnvironmentConfig.reset();
    });

    test('should create instance with correct values', () {
      const environment = Environment.dev;
      const name = 'Test Environment';
      const appName = 'Test App';
      const appIcon = 'assets/test_icon.png';
      const baseUrl = 'https://test-api.com';

      final config = EnvironmentConfig(
        environment: environment,
        name: name,
        appName: appName,
        appIcon: appIcon,
        baseUrl: baseUrl,
      );

      expect(config.environment, equals(environment));
      expect(config.name, equals(name));
      expect(config.appName, equals(appName));
      expect(config.appIcon, equals(appIcon));
      expect(config.baseUrl, equals(baseUrl));
    });

    test('should return the same instance when created multiple times', () {
      final config1 = EnvironmentConfig(
        environment: Environment.local,
        name: 'Local',
        appName: 'Local App',
        appIcon: 'assets/local_icon.png',
        baseUrl: 'http://localhost:3000',
      );

      final config2 = EnvironmentConfig(
        environment: Environment.prod,
        name: 'Production',
        appName: 'Prod App',
        appIcon: 'assets/prod_icon.png',
        baseUrl: 'https://api.prod.com',
      );

      expect(config1, equals(config2));
      expect(EnvironmentConfig.instance, equals(config1));
    });

    test('should correctly identify local environment', () {
      EnvironmentConfig(
        environment: Environment.local,
        name: 'Local',
        appName: 'Local App',
        appIcon: 'assets/local_icon.png',
        baseUrl: 'http://localhost:3000',
      );

      expect(EnvironmentConfig.isLocal(), isTrue);
      expect(EnvironmentConfig.isDevelopment(), isFalse);
      expect(EnvironmentConfig.isProduction(), isFalse);
    });

    test('should correctly identify development environment', () {
      EnvironmentConfig(
        environment: Environment.dev,
        name: 'Development',
        appName: 'Dev App',
        appIcon: 'assets/dev_icon.png',
        baseUrl: 'https://dev-api.com',
      );

      expect(EnvironmentConfig.isLocal(), isFalse);
      expect(EnvironmentConfig.isDevelopment(), isTrue);
      expect(EnvironmentConfig.isProduction(), isFalse);
    });

    test('should correctly identify production environment', () {
      EnvironmentConfig(
        environment: Environment.prod,
        name: 'Production',
        appName: 'Prod App',
        appIcon: 'assets/prod_icon.png',
        baseUrl: 'https://api.prod.com',
      );

      expect(EnvironmentConfig.isLocal(), isFalse);
      expect(EnvironmentConfig.isDevelopment(), isFalse);
      expect(EnvironmentConfig.isProduction(), isTrue);
    });

    test('should return false for environment checks when no instance exists', () {
      EnvironmentConfig.reset();

      expect(EnvironmentConfig.isLocal(), isFalse);
      expect(EnvironmentConfig.isDevelopment(), isFalse);
      expect(EnvironmentConfig.isProduction(), isFalse);
    });

    test('should throw error when accessing instance before creation', () {
      EnvironmentConfig.reset();

      expect(() => EnvironmentConfig.instance, throwsA(isA<TypeError>()));
    });
  });
} 