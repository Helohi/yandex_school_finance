import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TabbarPage extends StatelessWidget {
  const TabbarPage({super.key, required this.navShell});

  final StatefulNavigationShell navShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/spends.svg",
              colorFilter: _currentColorFilter(context, 0),
            ),
            label: 'Расходы',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/incomes.svg",
              colorFilter: _currentColorFilter(context, 1),
            ),
            label: "Доходы",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/calculator.svg",
              colorFilter: _currentColorFilter(context, 2),
            ),
            label: "Счет",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/articles.svg",
              colorFilter: _currentColorFilter(context, 3),
            ),
            label: "Статьи",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/settings.svg",
              colorFilter: _currentColorFilter(context, 4),
            ),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }

  ColorFilter? _currentColorFilter(BuildContext context, int iconIndex) {
    if (iconIndex == navShell.currentIndex) {
      return ColorFilter.mode(
        Theme.of(
          context,
        ).navigationBarTheme.iconTheme!.resolve({WidgetState.selected})!.color!,
        BlendMode.srcIn,
      );
    }
    return null;
  }

  void _goBranch(int index) {
    navShell.goBranch(index, initialLocation: index == navShell.currentIndex);
  }
}
