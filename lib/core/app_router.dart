import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_school_finance/core/service_locator.dart';
import 'package:yandex_school_finance/presentation/blocs/history_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/transaction_cubit.dart';
import 'package:yandex_school_finance/presentation/pages/history_page.dart';
import 'package:yandex_school_finance/presentation/pages/todays_transaction_page.dart';
import 'package:yandex_school_finance/presentation/pages/navigatino_bar_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", redirect: (context, state) => "/spends"),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            NavigationBarPage(navShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/spends",
                builder: _todaysTransactionsBuilder(false),
                routes: [
                  GoRoute(path: "/history", builder: _historyBuilder(false)),
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
                  GoRoute(path: "/history", builder: _historyBuilder(true)),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/calculate",
                builder: (context, state) => const Placeholder(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/articles",
                builder: (context, state) => const Placeholder(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/settings",
                builder: (context, state) => const Placeholder(),
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
  Widget wrapper(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => TransactionCubit(sl()),
      child: TodaysTransactionsPage(isIncome: isIncome),
    );
  }

  return wrapper;
}

Widget Function(BuildContext, GoRouterState) _historyBuilder(bool isIncome) {
  Widget wrapper(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => HistoryCubit(sl()),
      child: HistoryPage(isIncome: isIncome),
    );
  }

  return wrapper;
}
