import 'package:flutter/material.dart';

/// System-font typography tuned for short, touch-first sessions.
///
/// Brand typefaces will replace the system stack in a later lot.
abstract final class AppTypography {
  static const String? _fontFamily = null;

  /// Light [TextTheme] with a short, readable hierarchy.
  static TextTheme get light {
    return const TextTheme(
      displayLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.4,
      ),
      titleLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.2,
      ),
      titleMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      bodyLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      bodyMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.45,
      ),
      labelLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      labelMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
    );
  }
}
