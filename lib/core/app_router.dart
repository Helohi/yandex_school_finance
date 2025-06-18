import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_school_finance/core/service_locator.dart';
import 'package:yandex_school_finance/presentation/blocs/history_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/transaction_cubit.dart';
import 'package:yandex_school_finance/presentation/pages/history_page.dart';
import 'package:yandex_school_finance/presentation/pages/todays_transaction_page.dart';
import 'package:yandex_school_finance/presentation/pages/tabbar_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", redirect: (context, state) => "/spends"),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            TabbarPage(navShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/spends",
                builder: (context, state) => BlocProvider(
                  create: (context) => TransactionCubit(sl()),
                  child: TodaysTransactionsPage(isIncome: false),
                ),
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
                builder: (context, state) => BlocProvider(
                  create: (context) => TransactionCubit(sl()),
                  child: TodaysTransactionsPage(isIncome: true),
                ),
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

Widget Function(BuildContext, GoRouterState) _historyBuilder(bool isIncome) {
  Widget wrapper(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => HistoryCubit(),
      child: HistoryPage(isIncome: isIncome),
    );
  }

  return wrapper;
}
