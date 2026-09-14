import 'package:app_core/app_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/app.dart';
import 'package:mobile/app/bootstrap/app_bootstrap.dart';

void main() {
  test('AppConfig.fromEnvironment is available for bootstrap', () {
    final config = AppConfig.fromEnvironment();
    expect(config.environment, AppEnvironment.development);
  });

  testWidgets('installErrorHandlers does not break widget tests', (
    tester,
  ) async {
    final previousFlutterOnError = FlutterError.onError;
    final previousPlatformOnError = PlatformDispatcher.instance.onError;
    addTearDown(() {
      FlutterError.onError = previousFlutterOnError;
      PlatformDispatcher.instance.onError = previousPlatformOnError;
    });

    installErrorHandlers();

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
