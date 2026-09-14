import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Placeholder games destination.
class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Center(
        child: Text('Jeux', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
