import 'package:flutter/material.dart';
import 'package:yandex_school_finance/core/app_themes.dart';
import 'package:yandex_school_finance/presentation/pages/tabbar_page.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: TabbarPage(),
    );
  }
}
