import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_school_finance/core/extensions/date_to_string.dart';
import 'package:yandex_school_finance/core/extensions/number_formatting.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/presentation/blocs/history_cubit.dart';
import 'package:yandex_school_finance/presentation/widgets/top_list_tile.dart';
import 'package:yandex_school_finance/presentation/widgets/transaction_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.isIncome});

  final bool isIncome;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTimeRange _selectedRange = DateTimeRange(
    start: DateTime.now().copyWith(month: DateTime.now().month - 1),
    end: DateTime.now(),
  );
  Set<String> _currentSortType = {"byDate"};
  bool _isAscending = false;

  @override
  void initState() {
    super.initState();
    _updateTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).my_history),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.go("${GoRouterState.of(context).uri}/analyses");
            },
            icon: Icon(Icons.pending_actions),
          ),
        ],
      ),
      body: Column(
        children: [
          TopListTile(
            title: AppLocalizations.of(context).start,
            trailing: Text(_selectedRange.start.toHumanString()),
            onTap: _changeDateRange,
          ),
          TopListTile(
            title: AppLocalizations.of(context).end,
            trailing: Text(_selectedRange.end.toHumanString()),
            onTap: _changeDateRange,
          ),
          TopListTile(
            title: AppLocalizations.of(context).sort,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _sortingOrderChanged,
                  icon: _isAscending
                      ? Icon(CupertinoIcons.sort_up)
                      : Icon(CupertinoIcons.sort_down),
                ),
                SegmentedButton(
                  segments: [
                    ButtonSegment(value: "byDate", label: Text(AppLocalizations.of(context).date)),
                    ButtonSegment(value: "byAmount", label: Text(AppLocalizations.of(context).total)),
                  ],
                  showSelectedIcon: false,
                  selected: _currentSortType,
                  onSelectionChanged: _changeSortType,
                ),
              ],
            ),
          ),
          BlocBuilder<HistoryCubit, HistoryUIState>(
            builder: (context, state) => switch (state) {
              LoadedState() => TopListTile(
                title: AppLocalizations.of(context).total,
                trailing: Text(
                  "${TransactionResponseModel.sumOfTransactions(state.transactions).formatWithSpaces()} ₽",
                ),
              ),
              _ => SizedBox.shrink(),
            },
          ),
          BlocBuilder<HistoryCubit, HistoryUIState>(
            builder: (context, state) => switch (state) {
              InitialState() => SizedBox.shrink(),
              LoadingState() => Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CircularProgressIndicator(),
              ),
              LoadedState() => Expanded(
                child: ListView.builder(
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    final transactionTime =
                        state.transactions[index].transactionDate;
                    return TransactionTile(
                      transactionCategoryName:
                          state.transactions[index].category.name,
                      transactionAmount:
                          "${state.transactions[index].amount.toDouble().formatWithSpaces()} ₽",
                      transactionComment: state.transactions[index].comment,
                      emoji: widget.isIncome
                          ? null
                          : state.transactions[index].category.emoji,
                      time: "${transactionTime.hour}:${transactionTime.minute}",
                    );
                  },
                ),
              ),
              ErrorState() => Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(state.message(context)),
              ),
            },
          ),
        ],
      ),
    );
  }

  void _updateTransactions() {
    context.read<HistoryCubit>().getTransactionsInPeriod(
      widget.isIncome,
      startDate: _selectedRange.start,
      endDate: _selectedRange.end,
      sortBy: _currentSortType.first,
      isAscending: _isAscending,
    );
  }

  void _changeDateRange() async {
    final DateTimeRange? rangePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: _selectedRange,
      currentDate: DateTime.now(),
    );

    // Check for correct start and end dates order happens in the use case
    // as in DateRangePicker it is impossible

    if (rangePicked != null) {
      setState(() => _selectedRange = rangePicked);
      _updateTransactions();
    }
  }

  void _changeSortType(Set<String> sortType) {
    setState(() => _currentSortType = sortType);
    _updateTransactions();
  }

  void _sortingOrderChanged() {
    setState(() => _isAscending = !_isAscending);
    _updateTransactions();
  }
}
