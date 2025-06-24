import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/presentation/blocs/transaction_cubit.dart';
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
        title: Text("${widget.isIncome ? "Доходы" : "Расходы"} сегодня"),
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
            LoadingState() => Center(child: CircularProgressIndicator()),
            LoadedState() => Builder(
              builder: (context) {
                return Column(
                  children: [
                    TopListTile(
                      title: "Всего",
                      trailing: Text(
                        "${TransactionResponseModel.sumOfTransactions(state.transactions)} ₽",
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.transactions.length,
                        itemBuilder: (context, index) => TransactionTile(
                          state.transactions[index],
                          showEmoji: !widget.isIncome,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            ErrorState() => Center(child: Text(state.message)),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
