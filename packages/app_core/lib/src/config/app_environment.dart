/// Compile-time application environment.
enum AppEnvironment {
  development,
  staging,
  production;

  /// Parses a raw `APP_ENV` value.
  ///
  /// Throws [ArgumentError] for unknown or empty values so misconfiguration
  /// never silently falls back to [production].
  static AppEnvironment parse(String value) {
    switch (value) {
      case 'development':
        return AppEnvironment.development;
      case 'staging':
        return AppEnvironment.staging;
      case 'production':
        return AppEnvironment.production;
      default:
        throw ArgumentError.value(
          value,
          'APP_ENV',
          'Expected one of: development, staging, production.',
        );
    }
  }
}
