import 'package:flutter/material.dart';

/// Fundamental motion durations and curves.
///
/// Product micro-interactions are not implemented yet — these tokens prepare
/// consistent timing for later lots.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 120);
  static const Duration normal = Duration(milliseconds: 220);
  static const Duration slow = Duration(milliseconds: 360);

  static const Curve standard = Curves.easeInOut;
  static const Curve emphasized = Curves.easeOutCubic;
}
