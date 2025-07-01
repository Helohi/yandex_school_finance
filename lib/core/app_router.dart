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
import 'package:yandex_school_finance/presentation/blocs/transaction_cubit.dart';
import 'package:yandex_school_finance/presentation/pages/account_page.dart';
import 'package:yandex_school_finance/presentation/pages/analyses_page.dart';
import 'package:yandex_school_finance/presentation/pages/categories_page.dart';
import 'package:yandex_school_finance/presentation/pages/edit_account_page.dart';
import 'package:yandex_school_finance/presentation/pages/history_page.dart';
import 'package:yandex_school_finance/presentation/pages/todays_transaction_page.dart';
import 'package:yandex_school_finance/presentation/pages/navigation_bar_page.dart';

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
                builder: (context, state) => BlocProvider(
                  create: (context) => AccountCubit(sl(), sl()),
                  child: AccountPage(),
                ),
                routes: [
                  GoRoute(
                    path: "/edit/:id",
                    builder: (context, state) {
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
                builder: (context, state) => BlocProvider(
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

List<GoRoute> _historyRoutes(bool isIncome) {
  return [
    GoRoute(
      path: "/analyses",
      builder: (context, state) => BlocProvider(
        create: (context) => AnalysesCubit(sl()),
        child: AnalysesPage(isIncome: isIncome),
      ),
    ),
  ];
}
