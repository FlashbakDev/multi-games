import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Minimal logging facade over [developer.log].
///
/// Do not log passwords, auth tokens, payment data, secrets, or full user
/// payloads. No automatic redaction is implemented in this foundation lot.
abstract final class AppLogger {
  static const String _name = 'multi_games';

  /// Developer diagnostics. Skipped in release builds.
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (kReleaseMode) {
      return;
    }
    _log(message, level: 500, error: error, stackTrace: stackTrace);
  }

  /// Notable, expected technical events.
  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    _log(message, level: 800, error: error, stackTrace: stackTrace);
  }

  /// Recoverable abnormal situations.
  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _log(message, level: 900, error: error, stackTrace: stackTrace);
  }

  /// Real failures. Prefer including [error] and [stackTrace] when available.
  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log(message, level: 1000, error: error, stackTrace: stackTrace);
  }

  static void _log(
    String message, {
    required int level,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _name,
      level: level,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
