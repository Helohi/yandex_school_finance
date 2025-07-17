import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_school_finance/presentation/blocs/material_app_cubit.dart';

class NavigationBarPage extends StatelessWidget {
  const NavigationBarPage({super.key, required this.navShell});

  final StatefulNavigationShell navShell;

  @override
  Widget build(BuildContext context) {
    return BlurWhenInactive(
      child: Scaffold(
        body: navShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navShell.currentIndex,
          onDestinationSelected: _goBranch(context),
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                "assets/icons/spends.svg",
                colorFilter: _currentColorFilter(context, 0),
              ),
              label: AppLocalizations.of(context).outcomes,
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                "assets/icons/incomes.svg",
                colorFilter: _currentColorFilter(context, 1),
              ),
              label: AppLocalizations.of(context).incomes,
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                "assets/icons/calculator.svg",
                colorFilter: _currentColorFilter(context, 2),
              ),
              label: AppLocalizations.of(context).account,
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                "assets/icons/articles.svg",
                colorFilter: _currentColorFilter(context, 3),
              ),
              label: AppLocalizations.of(context).accounts,
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                "assets/icons/settings.svg",
                colorFilter: _currentColorFilter(context, 4),
              ),
              label: AppLocalizations.of(context).settings,
            ),
          ],
        ),
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

  void Function(int index) _goBranch(BuildContext context) {
    void insideFunc(int index) {
      context.read<MaterialAppCubit>().triggerHapticFeedback();
      navShell.goBranch(index, initialLocation: index == navShell.currentIndex);
    }

    return insideFunc;
  }
}

class BlurWhenInactive extends StatefulWidget {
  const BlurWhenInactive({super.key, required this.child});

  final Widget child;

  @override
  State<BlurWhenInactive> createState() => _BlurWhenInactiveState();
}

class _BlurWhenInactiveState extends State<BlurWhenInactive>
    with WidgetsBindingObserver {
  bool shouldBlur = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(
      () => shouldBlur =
          state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (shouldBlur)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200.withAlpha(100),
            ),
          ),
      ],
    );
  }
}
