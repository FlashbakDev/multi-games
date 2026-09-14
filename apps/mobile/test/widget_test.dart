import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/app.dart';
import 'package:mobile/app/router/app_router.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';

void main() {
  testWidgets('App builds successfully', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('uses design_system light theme', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.theme?.colorScheme.primary, AppColors.light.primary);
    expect(
      materialApp.theme?.scaffoldBackgroundColor,
      AppColors.light.background,
    );
    expect(materialApp.theme?.extension<AppColors>(), isNotNull);
  });

  testWidgets('starts on Accueil with navigation destinations', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Accueil'), findsWidgets);
    expect(find.text('Jeux'), findsWidgets);
    expect(find.text('Profil'), findsWidgets);
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      0,
    );
  });

  testWidgets('navigates to Jeux', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Jeux').last);
    await tester.pumpAndSettle();

    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      1,
    );
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('navigates to Profil', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profil').last);
    await tester.pumpAndSettle();

    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      2,
    );
  });

  testWidgets('returns to Accueil from another tab', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Jeux').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Accueil').last);
    await tester.pumpAndSettle();

    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      0,
    );
  });

  testWidgets('unknown route shows Page introuvable and returns home', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/route-inconnue');
    await tester.pumpWidget(App(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Page introuvable'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    await tester.tap(find.text('Retour à l\'accueil'));
    await tester.pumpAndSettle();

    expect(find.text('Page introuvable'), findsNothing);
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      0,
    );
  });

  testWidgets('switching branches preserves HomeScreen state', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    final homeState = tester.state(find.byType(HomeScreen));

    await tester.tap(find.text('Jeux').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profil').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Accueil').last);
    await tester.pumpAndSettle();

    expect(tester.state(find.byType(HomeScreen)), same(homeState));
  });
}
