import 'package:app_core/src/config/app_environment.dart';

/// Immutable compile-time application configuration.
///
/// Built from `--dart-define` values. Those values can appear in the binary and
/// must never be treated as secrets.
final class AppConfig {
  const AppConfig({required this.environment});

  /// Reads `APP_ENV` (default: `development` when the define is omitted).
  factory AppConfig.fromEnvironment({
    String appEnv = const String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    ),
  }) {
    return AppConfig(environment: AppEnvironment.parse(appEnv));
  }

  final AppEnvironment environment;
}
