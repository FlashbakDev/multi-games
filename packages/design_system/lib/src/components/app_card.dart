import 'package:design_system/src/theme/app_colors.dart';
import 'package:design_system/src/tokens/app_radius.dart';
import 'package:design_system/src/tokens/app_spacing.dart';
import 'package:flutter/material.dart';

/// Soft surface container for grouping related content.
///
/// No business logic — layout and product content stay in features.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: AppRadius.borderLg,
        border: Border.all(color: colors.border),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
