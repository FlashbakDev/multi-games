import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Placeholder profile destination.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Center(
        child: Text('Profil', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
