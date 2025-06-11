import 'package:flutter/material.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({super.key});

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage,
        onDestinationSelected: (value) => setState(() => currentPage = value),
        destinations: [
          NavigationDestination(
            icon: ImageIcon(AssetImage("assets/icons/spends.png")),
            label: 'Расходы',
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage("assets/icons/incomes.png")),
            label: "Доходы",
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage("assets/icons/calculator.png")),
            label: "Счет",
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage("assets/icons/articles.png")),
            label: "Статьи",
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage("assets/icons/settings.png")),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}
