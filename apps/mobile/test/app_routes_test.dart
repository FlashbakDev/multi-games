import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/router/app_routes.dart';

void main() {
  test('AppRoutes expose the three main paths', () {
    expect(AppRoutes.home, '/');
    expect(AppRoutes.games, '/games');
    expect(AppRoutes.profile, '/profile');
  });
}
