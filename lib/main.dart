import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yandex_school_finance/core/app_themes.dart';
import 'package:yandex_school_finance/core/app_router.dart';
import 'package:yandex_school_finance/core/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await dotenv.load();

  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
    );
  }
}
