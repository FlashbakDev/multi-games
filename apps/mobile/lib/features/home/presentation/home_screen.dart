import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Placeholder home destination.
///
/// Stateful so branch preservation under [StatefulShellRoute.indexedStack]
/// can be observed in tests via [State] identity.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Center(
        child: Text('Accueil', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
