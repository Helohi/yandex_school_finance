import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_school_finance/core/service_locator.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/presentation/blocs/account_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/analyses_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/categories_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/edit_account_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/history_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/material_app_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/settings_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/transaction_cubit.dart';
import 'package:yandex_school_finance/presentation/pages/account_page.dart';
import 'package:yandex_school_finance/presentation/pages/analyses_page.dart';
import 'package:yandex_school_finance/presentation/pages/categories_page.dart';
import 'package:yandex_school_finance/presentation/pages/edit_account_page.dart';
import 'package:yandex_school_finance/presentation/pages/history_page.dart';
import 'package:yandex_school_finance/presentation/pages/pin_code_page.dart';
import 'package:yandex_school_finance/presentation/pages/settings_page.dart';
import 'package:yandex_school_finance/presentation/pages/todays_transaction_page.dart';
import 'package:yandex_school_finance/presentation/pages/navigation_bar_page.dart';

class AppRouter {
  static int hapticLevel = 0;
  static String? _afterPinRedirect;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: "root",
  );

  static GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/settings",
    redirect: (context, state) {
      if (context.read<MaterialAppCubit>().isAuthenticated) {
        return state.fullPath;
      }
      _afterPinRedirect = state.fullPath;
      return "/pin";
    },

    routes: [
      GoRoute(path: "/", redirect: (_, _) => "/spends"),
      GoRoute(
        path: "/pin",
        builder: (context, state) => PinCodePage(
          onBiometricsPassed: () {
            context.read<MaterialAppCubit>().auth();
            if (_afterPinRedirect == state.fullPath) _afterPinRedirect = null;
            return _afterPinRedirect ?? "/spends";
          },
          onSubmitGoTo: (pin) {
            if (context.read<MaterialAppCubit>().checkPin(pin)) {
              context.read<MaterialAppCubit>().auth();
              if (_afterPinRedirect == state.fullPath) _afterPinRedirect = null;
              return _afterPinRedirect ?? "/spends";
            }
            return null;
          },
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) =>
            NavigationBarPage(navShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/spends",
                builder: _todaysTransactionsBuilder(false),
                routes: [
                  GoRoute(
                    path: "/history",
                    builder: _historyBuilder(false),
                    routes: _historyRoutes(false),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/incomes",
                builder: _todaysTransactionsBuilder(true),
                routes: [
                  GoRoute(
                    path: "/history",
                    builder: _historyBuilder(true),
                    routes: _historyRoutes(true),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/account",
                builder: (_, _) => BlocProvider(
                  create: (context) => AccountCubit(sl(), sl(), sl()),
                  child: AccountPage(),
                ),
                routes: [
                  GoRoute(
                    path: "/edit/:id",
                    builder: (_, state) {
                      final account = state.extra as AccountModel?;
                      return BlocProvider(
                        create: (context) => EditAccountCubit(sl()),
                        child: EditAccountPage(
                          id: state.pathParameters["id"],
                          account: account,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/categories",
                builder: (_, _) => BlocProvider(
                  create: (context) => CategoriesCubit(sl()),
                  child: CategoriesPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/settings",
                builder: (_, _) => BlocProvider(
                  create: (context) => SettingsCubit(),
                  child: SettingsPage(),
                ),
                routes: [
                  GoRoute(
                    path: "/setPin",
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, _) => PinCodePage(
                      onSubmitGoTo: (pin) {
                        context.read<MaterialAppCubit>().setPin(pin);
                        return "/settings";
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget Function(BuildContext, GoRouterState) _todaysTransactionsBuilder(
  bool isIncome,
) {
  Widget wrapper(BuildContext _, GoRouterState _) {
    return BlocProvider(
      create: (context) => TransactionCubit(sl()),
      child: TodaysTransactionsPage(isIncome: isIncome),
    );
  }

  return wrapper;
}

Widget Function(BuildContext, GoRouterState) _historyBuilder(bool isIncome) {
  Widget wrapper(BuildContext _, GoRouterState _) {
    return BlocProvider(
      create: (context) => HistoryCubit(sl()),
      child: HistoryPage(isIncome: isIncome),
    );
  }

  return wrapper;
}

List<GoRoute> _historyRoutes(bool isIncome) {
  return [
    GoRoute(
      path: "/analyses",
      builder: (_, _) => BlocProvider(
        create: (context) => AnalysesCubit(sl()),
        child: AnalysesPage(isIncome: isIncome),
      ),
    ),
  ];
}
