import 'package:app_core/app_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppEnvironment.parse', () {
    test('parses development', () {
      expect(AppEnvironment.parse('development'), AppEnvironment.development);
    });

    test('parses staging', () {
      expect(AppEnvironment.parse('staging'), AppEnvironment.staging);
    });

    test('parses production', () {
      expect(AppEnvironment.parse('production'), AppEnvironment.production);
    });

    test('rejects unknown values', () {
      expect(
        () => AppEnvironment.parse('prod'),
        throwsA(isA<ArgumentError>().having((e) => e.name, 'name', 'APP_ENV')),
      );
    });

    test('rejects empty values instead of defaulting', () {
      expect(() => AppEnvironment.parse(''), throwsArgumentError);
    });
  });

  group('AppConfig', () {
    test('fromEnvironment defaults to development when APP_ENV is omitted', () {
      final config = AppConfig.fromEnvironment();
      expect(config.environment, AppEnvironment.development);
    });

    test('fromEnvironment parses an injected APP_ENV value', () {
      final config = AppConfig.fromEnvironment(appEnv: 'staging');
      expect(config.environment, AppEnvironment.staging);
    });

    test('fromEnvironment throws on invalid APP_ENV', () {
      expect(
        () => AppConfig.fromEnvironment(appEnv: 'local'),
        throwsArgumentError,
      );
    });
  });
}
