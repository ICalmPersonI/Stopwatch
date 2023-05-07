import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:stopwatch_dart/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('testing the functionality of the stopwatch',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          final Finder refreshButton = find
              .image(const AssetImage('assets/icons/refresh-svgrepo-com.svg'));

          await tester.tap(find.text('00:00:00:00'));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 5), () {});
          await tester.pumpAndSettle();

          expect(find.textContaining(RegExp(r'^00:00:05:\d{2}$')), findsOneWidget);
        });

    testWidgets('testing the functionality of the refresh button ',
            (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('00:00:00:00'));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 5), () {});
      await tester.pumpAndSettle();

      expect(find.textContaining(RegExp(r'^00:00:05:\d{2}$')), findsOneWidget);

      await tester.tap(find.textContaining(RegExp(r'^00:00:05:\d{2}$')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey("refresh_button")));
      await tester.pumpAndSettle();

      expect(find.text('00:00:00:00'), findsOneWidget);
    });

  });
}