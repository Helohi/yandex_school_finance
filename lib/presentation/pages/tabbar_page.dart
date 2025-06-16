import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            icon: SvgPicture.asset(
              "assets/icons/spends.svg",
              colorFilter: _currentColorFilter(0),
            ),
            label: 'Расходы',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/incomes.svg",
              colorFilter: _currentColorFilter(1),
            ),
            label: "Доходы",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/calculator.svg",
              colorFilter: _currentColorFilter(2),
            ),
            label: "Счет",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/articles.svg",
              colorFilter: _currentColorFilter(3),
            ),
            label: "Статьи",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/settings.svg",
              colorFilter: _currentColorFilter(4),
            ),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }

  ColorFilter? _currentColorFilter(int iconIndex) {
    if (iconIndex == currentPage) {
      return ColorFilter.mode(
        Theme.of(
          context,
        ).navigationBarTheme.iconTheme!.resolve({WidgetState.selected})!.color!,
        BlendMode.srcIn,
      );
    }
    return null;
  }
}
