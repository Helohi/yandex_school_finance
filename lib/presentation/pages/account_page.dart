import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shake/shake.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/core/enums/period_enum.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/presentation/blocs/account_cubit.dart';
import 'package:yandex_school_finance/presentation/widgets/account_top_tile.dart';
import 'package:yandex_school_finance/presentation/widgets/background_barrier.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_error_text.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_progress_indicator.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isBalanceVisible = true;
  late final ShakeDetector _shakeDetector;
  late final DateTime statisticEndDate;
  late final DateTime statisticStartDate;

  Set<PeriodEnum> _selectedPeriod = {PeriodEnum.month};
  Map<DateTime, Decimal>? _statisticsData;

  @override
  void initState() {
    super.initState();
    statisticEndDate = DateTime.now();
    statisticStartDate = statisticEndDate.copyWith(
      month: statisticEndDate.month - 1,
    );

    _startShakeDetector();

    context.read<AccountCubit>().loadAccount();
  }

  @override
  void dispose() {
    _shakeDetector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Мой счет"),
        centerTitle: true,
        actions: [
          BlocBuilder<AccountCubit, MainAccountStateUI>(
            buildWhen: (previous, current) => current is AccountStateUI,
            builder: (context, state) {
              if (state is! AccountLoadedState) return SizedBox.shrink();
              return IconButton(
                onPressed: () async {
                  final newAccount = await context.push<AccountUpdateRequestModel>(
                    "${GoRouterState.of(context).uri}/edit/${state.account.id}",
                    extra: state.account,
                  );
                  if (newAccount != null && context.mounted) {
                    context.read<AccountCubit>().updateAccount(
                      state.account.id,
                      newAccount,
                    );
                  }
                },
                icon: Icon(Icons.edit_outlined),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<AccountCubit, MainAccountStateUI>(
        listenWhen: (previous, current) =>
            current is AccountLoadedState ||
            current is AccountStatisticsLoadedState,
        listener: (context, state) {
          if (state is AccountLoadedState) {
            context.read<AccountCubit>().loadStatistics(_selectedPeriod.first);
          } else if (state is AccountStatisticsLoadedState) {
            setState(() => _statisticsData = state.statistics);
          }
        },
        buildWhen: (previous, current) => current is AccountStateUI,
        builder: (context, state) {
          if (state is! AccountStateUI) {
            // InitialState
            return SizedBox.shrink();
          }
          return switch (state) {
            AccountLoadingState() => CenteredProgressIndicator(),
            AccountLoadedState() => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// account name and balance
                AccountTopTile(
                  leadingLabel: state.account.name,
                  trailingLabel: Container(
                    color: _isBalanceVisible
                        ? Colors.transparent
                        : Colors.black,
                    child: Text(
                      "${state.account.balance} ${state.account.currency.symbol}",
                      style: Theme.of(
                        context,
                      ).listTileTheme.leadingAndTrailingTextStyle,
                    ),
                  ),
                  emoji: "💰",
                ),

                /// currency
                AccountTopTile(
                  leadingLabel: "Валюта",
                  trailingLabel: Text(
                    state.account.currency.symbol,
                    style: Theme.of(
                      context,
                    ).listTileTheme.leadingAndTrailingTextStyle,
                  ),
                  onTap: () => _showCurrencyPicker(context),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SegmentedButton<PeriodEnum>(
                    showSelectedIcon: false,
                    style: SegmentedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    segments: [
                      ButtonSegment(
                        value: PeriodEnum.month,
                        label: Text("Месяц"),
                      ),
                      ButtonSegment(value: PeriodEnum.year, label: Text("Год")),
                    ],
                    selected: _selectedPeriod,
                    onSelectionChanged: (value) {
                      setState(() => _selectedPeriod = value);
                      context.read<AccountCubit>().loadStatistics(
                        _selectedPeriod.first,
                      );
                    },
                  ),
                ),

                /// graphic
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 412 / 220,
                    child: Stack(
                      children: [
                        if (_statisticsData != null)
                          BarChart(
                            BarChartData(
                              barGroups: List.generate(
                                _statisticsData!.length,
                                (index) => BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: _statisticsData!.values
                                          .elementAt(index)
                                          .toDouble()
                                          .abs(),
                                      color:
                                          _statisticsData!.values.elementAt(
                                                index,
                                              ) >
                                              Decimal.zero
                                          ? Colors.green
                                          : Colors.red,
                                      width: 6,
                                    ),
                                  ],
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 32,
                                    interval: 6,
                                    getTitlesWidget: (value, meta) {
                                      if (value % meta.appliedInterval != 0.0) {
                                        return const SizedBox.shrink();
                                      }
                                      final date = _statisticsData!.keys
                                          .elementAt(value.toInt());
                                      return switch (_selectedPeriod.first) {
                                        PeriodEnum.month => Text(
                                          "${date.day.toString().padLeft(2, '0')}"
                                          ".${date.month.toString().padLeft(2, '0')}",
                                        ),
                                        PeriodEnum.year => Text(
                                          "${date.month.toString().padLeft(2, '0')}"
                                          ".${date.year}",
                                        ),
                                      };
                                    },
                                  ),
                                ),
                              ),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        BlocBuilder<AccountCubit, MainAccountStateUI>(
                          buildWhen: (previous, current) =>
                              current is AccountStatisticsStateUI,
                          builder: (context, state) {
                            if (state is AccountStatisticsLoadingState) {
                              return BackgroundBarrier(
                                child: CenteredProgressIndicator(),
                              );
                            } else if (state is AccountStatisticsErrorState) {
                              return BackgroundBarrier(
                                child: CenteredErrorText(
                                  message: state.message,
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AccountErrorState() => CenteredErrorText(message: state.message),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  void _startShakeDetector() {
    _shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: (event) {
        setState(() => _isBalanceVisible = !_isBalanceVisible);
      },
    );
  }

  void _showCurrencyPicker(BuildContext contextWithBloc) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      showDragHandle: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        builder: (context, scrollController) => Theme(
          data: Theme.of(context).copyWith(
            listTileTheme: ListTileThemeData(
              horizontalTitleGap: 8,
              shape: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
              leadingAndTrailingTextStyle: Theme.of(context)
                  .listTileTheme
                  .leadingAndTrailingTextStyle
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                for (final currency in CurrencyEnum.values)
                  ListTile(
                    onTap: () {
                      contextWithBloc.read<AccountCubit>().changeCurrency(
                        currency,
                      );
                      Navigator.of(context).pop();
                    },
                    leading: Text(currency.symbol),
                    title: Text(currency.fullName),
                  ),
                ListTile(
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  tileColor: Color(0xffE46962),
                  leading: Icon(Icons.cancel_outlined),
                  title: Text("Отмена"),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
