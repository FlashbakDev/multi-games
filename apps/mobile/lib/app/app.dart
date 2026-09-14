import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/app_router.dart';

/// Root application widget.
///
/// Owns a single [GoRouter] instance so the router is not recreated on rebuild.
class App extends StatefulWidget {
  const App({super.key, GoRouter? router}) : _router = router;

  final GoRouter? _router;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router = widget._router ?? createAppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _router,
    );
  }
}
