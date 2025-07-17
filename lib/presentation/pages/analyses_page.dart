import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'dart:math';

import 'package:animated_finance_pie_chart/animated_finance_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/core/extensions/number_formatting.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/presentation/blocs/analyses_cubit.dart';
import 'package:yandex_school_finance/presentation/widgets/analyses_range_tile.dart';
import 'package:yandex_school_finance/presentation/widgets/background_barrier.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_error_text.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_progress_indicator.dart';
import 'package:yandex_school_finance/presentation/widgets/transaction_tile.dart';

class AnalysesPage extends StatefulWidget {
  const AnalysesPage({super.key, required this.isIncome});

  final bool isIncome;

  @override
  State<AnalysesPage> createState() => _AnalysesPageState();
}

class _AnalysesPageState extends State<AnalysesPage> {
  DateTimeRange _selectedRange = DateTimeRange(
    start: DateTime.now().copyWith(month: DateTime.now().month - 1),
    end: DateTime.now(),
  );

  double? _sumOfCurrentTransactions;
  List<CategorizedTransactions>? _currentCategorized;

  @override
  void initState() {
    super.initState();
    _updateTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).analysis),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              AnalysesRangeTile(
                title: AppLocalizations.of(context).period_start,
                onPressed: _showDateRangePicker,
                dateToShow: _selectedRange.start,
              ),
              AnalysesRangeTile(
                title: AppLocalizations.of(context).period_end,
                onPressed: _showDateRangePicker,
                dateToShow: _selectedRange.end,
              ),

              /// sum
              if (_sumOfCurrentTransactions != null)
                ListTile(
                  title: Text(AppLocalizations.of(context).total),
                  trailing: Text(
                    "${_sumOfCurrentTransactions!.formatWithSpaces()} ₽",
                  ),
                ),

              /// pie chart
              if (_currentCategorized != null &&
                  _sumOfCurrentTransactions != null)
                AnimatedFinanceAnalysisPieChart(
                  animationDuration: const Duration(seconds: 5),
                  totalVal: _sumOfCurrentTransactions!,
                  sectors: _currentCategorized!
                      .map(
                        (el) => FinanceSector(
                          value: TransactionResponseModel.sumOfTransactions(
                            el.transactions,
                          ),
                          color: Color((Random().nextInt(0xFFFFFFFF))),
                          label: el.category.name,
                        ),
                      )
                      .toList(),
                ),

              if (_currentCategorized != null &&
                  _sumOfCurrentTransactions != null)
                Expanded(
                  child: Column(
                    children: [
                      /// categories
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: ListView.builder(
                            itemCount: _currentCategorized!.length,
                            itemBuilder: (context, index) {
                              final localSumOfTransactions =
                                  TransactionResponseModel.sumOfTransactions(
                                    _currentCategorized![index].transactions,
                                  );
                              return TransactionTile(
                                onTap: () => showTransactionsFromCategory(
                                  _currentCategorized![index].transactions,
                                ),
                                transactionCategoryName:
                                    _currentCategorized![index].category.name,
                                transactionComment: _currentCategorized![index]
                                    .transactions
                                    .first
                                    .comment,
                                emoji:
                                    _currentCategorized![index].category.emoji,
                                transactionAmount:
                                    "${((localSumOfTransactions / _sumOfCurrentTransactions! * 10000).roundToDouble() / 100).formatWithSpaces()}%",
                                time:
                                    "${localSumOfTransactions.formatWithSpaces()} ₽",
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          /// loaders and errors
          BlocConsumer<AnalysesCubit, AnalysesUIState>(
            listenWhen: (previous, current) => current is LoadedState,
            listener: (context, state) {
              if (state is LoadedState) {
                setState(() {
                  _sumOfCurrentTransactions =
                      TransactionResponseModel.sumOfTransactions(
                        state.transactions,
                      );
                  _currentCategorized = state.categorized;
                });
              }
            },
            builder: (context, state) {
              switch (state) {
                case InitialState() || LoadingState():
                  return BackgroundBarrier(child: CenteredProgressIndicator());
                case ErrorState():
                  return BackgroundBarrier(
                    child: CenteredErrorText(message: state.message(context)),
                  );
                case LoadedState():
                  return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  void _showDateRangePicker() async {
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDateRange: _selectedRange,
    );

    if (newDateRange != null) {
      setState(() => _selectedRange = newDateRange);
      _updateTransactions();
    }
  }

  void _updateTransactions() {
    context.read<AnalysesCubit>().getTransactionsInPeriod(
      widget.isIncome,
      startDate: _selectedRange.start,
      endDate: _selectedRange.end,
    );
  }

  void showTransactionsFromCategory(
    List<TransactionResponseModel> transactions,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      scrollControlDisabledMaxHeightRatio: 0.9,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => ListView.builder(
          controller: scrollController,
          itemCount: transactions.length,
          itemBuilder: (context, index) => TransactionTile(
            transactionCategoryName: transactions[index].category.name,
            transactionComment: transactions[index].comment,
            transactionAmount:
                "${transactions[index].amount.toDouble().formatWithSpaces()} ₽",
            emoji: transactions[index].category.emoji,
          ),
        ),
      ),
    );
  }
}
