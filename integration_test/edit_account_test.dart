import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:yandex_school_finance/presentation/pages/material_app.dart';
import 'package:yandex_school_finance/core/service_locator.dart' as di;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await dotenv.load();
    await di.init();
  });

  testWidgets("Account name changing", (tester) async {
    await tester.pumpWidget(const FinanceApp());

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("AccountPage button")));

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("AccountEdit button")));

    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(ValueKey("NameTextField")),
      "accountTest",
    );

    await tester.tap(find.byKey(ValueKey("DoneIconButton")));

    await tester.pumpAndSettle();

    expect(find.text("accountTest"), findsOneWidget);
  });
}
