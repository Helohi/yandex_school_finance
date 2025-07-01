import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/core/extensions/date_to_string.dart';
import 'package:yandex_school_finance/core/extensions/number_formatting.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/presentation/blocs/analyses_cubit.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_error_text.dart';
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

  @override
  void initState() {
    super.initState();
    _updateTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Анализ"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          AnalysesRangeTile(
            title: "Период:начало",
            onPressed: _showDateRangePicker,
            dateToShow: _selectedRange.start,
          ),
          AnalysesRangeTile(
            title: "Период:конец",
            onPressed: _showDateRangePicker,
            dateToShow: _selectedRange.end,
          ),
          BlocBuilder<AnalysesCubit, AnalysesUIState>(
            builder: (context, state) {
              switch (state) {
                case InitialState() || LoadingState():
                  return CircularProgressIndicator();
                case ErrorState():
                  return CenteredErrorText(message: state.message);
                case LoadedState():
                  final sumOfTransactions =
                      TransactionResponseModel.sumOfTransactions(
                        state.transactions,
                      );
                  return Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Сумма"),
                          trailing: Text(
                            "${sumOfTransactions.formatWithSpaces()} ₽",
                          ),
                        ),
                        SizedBox(height: 185),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: ListView.builder(
                              itemCount: state.categorized.length,
                              itemBuilder: (context, index) {
                                final localSumOfTransactions =
                                    TransactionResponseModel.sumOfTransactions(
                                      state.categorized[index].transactions,
                                    );
                                return TransactionTile(
                                  onTap: () => showTransactionsFromCategory(
                                    state.categorized[index].transactions,
                                  ),
                                  transactionCategoryName:
                                      state.categorized[index].category.name,
                                  transactionComment: state
                                      .categorized[index]
                                      .transactions
                                      .first
                                      .comment,
                                  emoji:
                                      state.categorized[index].category.emoji,
                                  transactionAmount:
                                      "${(localSumOfTransactions / sumOfTransactions * 100).roundToDouble().formatWithSpaces()}%",
                                  time:
                                      "${localSumOfTransactions.formatWithSpaces()} ₽",
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showDateRangePicker() async {
    _selectedRange =
        await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          currentDate: DateTime.now(),
          initialDateRange: _selectedRange,
        ) ??
        _selectedRange;

    _updateTransactions();
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

class AnalysesRangeTile extends StatelessWidget {
  const AnalysesRangeTile({
    super.key,
    required this.title,
    required this.dateToShow,
    this.onPressed,
  });

  final String title;
  final DateTime dateToShow;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: ElevatedButton(
        onPressed: onPressed,
        child: Text(dateToShow.toHumanString()),
      ),
    );
  }
}
