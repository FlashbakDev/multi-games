import 'package:flutter/material.dart';

/// Semantic color tokens for the light theme.
///
/// Prefer [AppColors.of] / [ColorScheme] over hard-coded hex values in feature
/// code. Dark theme values are not defined yet.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryPressed,
    required this.primarySubtle,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceMuted,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.danger,
    required this.onDanger,
    required this.disabled,
    required this.onDisabled,
  });

  /// Brand indigo.
  static const Color _brandPrimary = Color(0xFF5B5FEF);

  /// Slightly darker brand for pressed states.
  static const Color _brandPrimaryPressed = Color(0xFF4A4ED6);

  /// Soft brand wash for subtle surfaces / secondary fills.
  static const Color _brandPrimarySubtle = Color(0xFFEDEEFD);

  static const Color _background = Color(0xFFF7F8FC);
  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _textPrimary = Color(0xFF1F2430);
  static const Color _textSecondary = Color(0xFF667085);
  static const Color _border = Color(0xFFE4E7EC);
  static const Color _success = Color(0xFF16A34A);
  static const Color _warning = Color(0xFFD97706);
  static const Color _danger = Color(0xFFDC2626);
  static const Color _disabled = Color(0xFFD0D5DD);
  static const Color _onDisabled = Color(0xFF98A2B3);
  static const Color _onBrand = Color(0xFFFFFFFF);
  static const Color _surfaceMuted = Color(0xFFF2F4F7);

  /// Default light semantic palette.
  static const AppColors light = AppColors(
    primary: _brandPrimary,
    onPrimary: _onBrand,
    primaryPressed: _brandPrimaryPressed,
    primarySubtle: _brandPrimarySubtle,
    background: _background,
    onBackground: _textPrimary,
    surface: _surface,
    onSurface: _textPrimary,
    surfaceMuted: _surfaceMuted,
    border: _border,
    textPrimary: _textPrimary,
    textSecondary: _textSecondary,
    success: _success,
    onSuccess: _onBrand,
    warning: _warning,
    onWarning: _onBrand,
    danger: _danger,
    onDanger: _onBrand,
    disabled: _disabled,
    onDisabled: _onDisabled,
  );

  final Color primary;
  final Color onPrimary;
  final Color primaryPressed;
  final Color primarySubtle;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceMuted;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color danger;
  final Color onDanger;
  final Color disabled;
  final Color onDisabled;

  /// Resolves semantic colors from the ambient [ThemeData].
  static AppColors of(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();
    if (colors == null) {
      throw StateError('AppColors is not registered on ThemeData.extensions');
    }
    return colors;
  }

  /// Material [ColorScheme] derived from these semantic tokens.
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      secondary: primarySubtle,
      onSecondary: primary,
      error: danger,
      onError: onDanger,
      surface: surface,
      onSurface: onSurface,
      outline: border,
      surfaceContainerHighest: surfaceMuted,
    );
  }

  @override
  AppColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryPressed,
    Color? primarySubtle,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceMuted,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? danger,
    Color? onDanger,
    Color? disabled,
    Color? onDisabled,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      primarySubtle: primarySubtle ?? this.primarySubtle,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      primarySubtle: Color.lerp(primarySubtle, other.primarySubtle, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      onDisabled: Color.lerp(onDisabled, other.onDisabled, t)!,
    );
  }
}
