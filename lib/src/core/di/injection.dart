import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  // For now, we'll manually register dependencies
  // When you add services, you can register them here
  // Example:
  // getIt.registerSingleton<AuthService>(AuthService());
  // getIt.registerLazySingleton<ApiService>(() => ApiService());
} 