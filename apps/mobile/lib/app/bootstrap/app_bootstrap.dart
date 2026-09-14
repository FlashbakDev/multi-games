import 'package:app_core/app_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/app.dart';

/// Boots the mobile application with config and error handlers.
///
/// Does not perform network I/O or product initialization.
Future<void> bootstrapApplication({
  AppConfig? config,
  Widget Function(AppConfig config)? appBuilder,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final resolvedConfig = config ?? AppConfig.fromEnvironment();
  installErrorHandlers();

  AppLogger.info(
    'Bootstrapping mobile app (${resolvedConfig.environment.name})',
  );

  runApp(appBuilder?.call(resolvedConfig) ?? const App());
}

/// Installs Flutter / platform error hooks that log then preserve reporting.
@visibleForTesting
void installErrorHandlers() {
  FlutterError.onError = (details) {
    AppLogger.error(
      'Flutter framework error',
      error: details.exception,
      stackTrace: details.stack,
    );
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.error(
      'Unhandled platform/async error',
      error: error,
      stackTrace: stack,
    );
    // false = still reported by the engine (not swallowed).
    return false;
  };
}
