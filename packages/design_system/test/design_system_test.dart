import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('light theme builds with expected structural values', () {
      final theme = AppTheme.light;

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, AppColors.light.primary);
      expect(theme.scaffoldBackgroundColor, AppColors.light.background);
      expect(theme.colorScheme.surface, AppColors.light.surface);
      expect(theme.extension<AppColors>()?.primary, AppColors.light.primary);
      expect(theme.extension<AppColors>()?.success, AppColors.light.success);
      expect(theme.textTheme.titleLarge?.fontSize, 22);
      expect(theme.textTheme.bodyLarge?.fontSize, 16);
      expect(theme.textTheme.labelLarge?.fontWeight, FontWeight.w600);
    });
  });

  group('AppButton', () {
    testWidgets('renders label and invokes onPressed', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton(label: 'Jouer', onPressed: () => tapped = true),
          ),
        ),
      );

      expect(find.text('Jouer'), findsOneWidget);
      await tester.tap(find.byType(AppButton));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('disabled does not invoke onPressed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(body: AppButton(label: 'Jouer')),
        ),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('loading blocks interaction and shows progress', (
      tester,
    ) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton(
              label: 'Jouer',
              isLoading: true,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(AppButton));
      await tester.pump();
      expect(tapped, isFalse);
    });

    testWidgets('optional icon is rendered', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton(
              label: 'Jouer',
              icon: Icons.play_arrow,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('handles increased text scale without overflow exception', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.5)),
              child: child!,
            );
          },
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 220,
                child: AppButton(
                  label: 'Continuer la partie',
                  isExpanded: true,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Continuer la partie'), findsOneWidget);
    });
  });

  group('AppCard', () {
    testWidgets('renders child with surface styling and padding', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(body: AppCard(child: Text('Contenu carte'))),
        ),
      );

      expect(find.text('Contenu carte'), findsOneWidget);

      final padding = tester.widget<Padding>(
        find.descendant(
          of: find.byType(AppCard),
          matching: find.byType(Padding),
        ),
      );
      expect(padding.padding, const EdgeInsets.all(AppSpacing.lg));

      final decorated = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(AppCard),
          matching: find.byType(DecoratedBox),
        ),
      );
      final decoration = decorated.decoration as BoxDecoration;
      expect(decoration.color, AppColors.light.surface);
      expect(decoration.borderRadius, AppRadius.borderLg);
    });
  });
}
