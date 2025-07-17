import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_school_finance/core/extensions/number_formatting.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/presentation/blocs/material_app_cubit.dart';
import 'package:yandex_school_finance/presentation/blocs/transaction_cubit.dart';
import 'package:yandex_school_finance/presentation/pages/edit_transaction_dialog.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_error_text.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_progress_indicator.dart';
import 'package:yandex_school_finance/presentation/widgets/top_list_tile.dart';
import 'package:yandex_school_finance/presentation/widgets/transaction_tile.dart';

class TodaysTransactionsPage extends StatefulWidget {
  const TodaysTransactionsPage({super.key, required this.isIncome});

  final bool isIncome;

  @override
  State<TodaysTransactionsPage> createState() => _TodaysTransactionsPageState();
}

class _TodaysTransactionsPageState extends State<TodaysTransactionsPage> {
  @override
  void initState() {
    super.initState();

    context.read<TransactionCubit>().loadTodayTransactions(widget.isIncome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.isIncome ? AppLocalizations.of(context).incomes : AppLocalizations.of(context).outcomes} ${AppLocalizations.of(context).today}",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push("${GoRouterState.of(context).uri}/history");
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: BlocBuilder<TransactionCubit, TransactionUIState>(
        builder: (context, state) {
          return switch (state) {
            InitialState() => SizedBox.shrink(),
            LoadingState() => CenteredProgressIndicator(),
            ErrorState() => CenteredErrorText(message: state.message(context)),
            LoadedState() => Builder(
              builder: (context) {
                return Column(
                  children: [
                    TopListTile(
                      title: AppLocalizations.of(context).total,
                      trailing: Text(
                        "${TransactionResponseModel.sumOfTransactions(state.transactions).formatWithSpaces()} ₽",
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.transactions.length,
                        itemBuilder: (context, index) => TransactionTile(
                          onTap: _showModifyTransactionDialog(
                            state.transactions[index],
                          ),
                          transactionCategoryName:
                              state.transactions[index].category.name,
                          transactionAmount:
                              '${state.transactions[index].amount.toDouble().formatWithSpaces()} ₽',
                          emoji: widget.isIncome
                              ? null
                              : state.transactions[index].category.emoji,
                          transactionComment: state.transactions[index].comment,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MaterialAppCubit>().triggerHapticFeedback();
          _showModifyTransactionDialog()();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void Function() _showModifyTransactionDialog([
    TransactionResponseModel? transaction,
  ]) {
    return () =>
        showDialog<bool>(
          context: context,
          builder: (context) => EditTransactionDialog(
            isIncome: widget.isIncome,
            transaction: transaction,
          ),
        ).then((isCreated) {
          if (isCreated == true && context.mounted) {
            context.read<TransactionCubit>().loadTodayTransactions(
              widget.isIncome,
            );
          }
        });
  }
}
