enum Environment {
  local,
  dev,
  prod,
}

class EnvironmentConfig {
  final Environment environment;
  final String name;
  final String appName;
  final String appIcon;
  final String baseUrl;

  static EnvironmentConfig? _instance;

  factory EnvironmentConfig({
    required Environment environment,
    required String name,
    required String appName,
    required String appIcon,
    required String baseUrl,
  }) {
    _instance ??= EnvironmentConfig._internal(
      environment: environment,
      name: name,
      appName: appName,
      appIcon: appIcon,
      baseUrl: baseUrl,
    );
    return _instance!;
  }

  EnvironmentConfig._internal({
    required this.environment,
    required this.name,
    required this.appName,
    required this.appIcon,
    required this.baseUrl,
  });

  static EnvironmentConfig get instance {
    return _instance!;
  }

  static bool isLocal() => _instance?.environment == Environment.local;
  static bool isDevelopment() => _instance?.environment == Environment.dev;
  static bool isProduction() => _instance?.environment == Environment.prod;
} 