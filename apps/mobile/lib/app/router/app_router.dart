import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/app_routes.dart';
import 'package:mobile/app/shell/app_shell.dart';
import 'package:mobile/features/games/presentation/games_screen.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/features/profile/presentation/profile_screen.dart';
import 'package:mobile/shared/presentation/not_found_screen.dart';

/// Creates the application [GoRouter].
///
/// [initialLocation] is mainly useful for tests (e.g. unknown routes).
GoRouter createAppRouter({String initialLocation = AppRoutes.home}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.games,
                builder: (context, state) => const GamesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
