import 'package:design_system/src/theme/app_colors.dart';
import 'package:design_system/src/tokens/app_radius.dart';
import 'package:design_system/src/tokens/app_spacing.dart';
import 'package:flutter/material.dart';

/// Visual style for [AppButton].
enum AppButtonVariant {
  /// Filled brand CTA.
  primary,

  /// Outlined / secondary action.
  secondary,

  /// Destructive action.
  danger,
}

/// Touch-first button primitive for the product shell.
///
/// Prefer this over inventing ad-hoc [FilledButton] styles in features.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isExpanded = false,
    this.icon,
  });

  const AppButton.secondary({
    required this.label,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isExpanded = false,
    this.icon,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.danger({
    required this.label,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isExpanded = false,
    this.icon,
  }) : variant = AppButtonVariant.danger;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;
  final IconData? icon;

  bool get _isDisabled => onPressed == null;
  bool get _canTap => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    final activeBackground = switch (variant) {
      AppButtonVariant.primary => colors.primary,
      AppButtonVariant.secondary => colors.surface,
      AppButtonVariant.danger => colors.danger,
    };
    final activeForeground = switch (variant) {
      AppButtonVariant.primary => colors.onPrimary,
      AppButtonVariant.secondary => colors.primary,
      AppButtonVariant.danger => colors.onDanger,
    };

    final background = _isDisabled ? colors.disabled : activeBackground;
    final foreground = _isDisabled ? colors.onDisabled : activeForeground;
    final pressedOverlay = switch (variant) {
      AppButtonVariant.primary => colors.primaryPressed.withValues(alpha: 0.24),
      AppButtonVariant.secondary => colors.primary.withValues(alpha: 0.08),
      AppButtonVariant.danger => colors.danger.withValues(alpha: 0.16),
    };

    final child = Row(
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: foreground,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ] else if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: AppSpacing.sm),
        ],
        Flexible(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.labelLarge,
          ),
        ),
      ],
    );

    final button = Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderLg,
        side: variant == AppButtonVariant.secondary
            ? BorderSide(color: _isDisabled ? colors.disabled : colors.border)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: _canTap ? onPressed : null,
        borderRadius: AppRadius.borderLg,
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return pressedOverlay;
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return foreground.withValues(alpha: 0.06);
          }
          return null;
        }),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 52, minWidth: 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: foreground),
              child: IconTheme.merge(
                data: IconThemeData(color: foreground),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );

    final sized = isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : button;

    return Semantics(
      button: true,
      enabled: _canTap,
      label: label,
      child: sized,
    );
  }
}
