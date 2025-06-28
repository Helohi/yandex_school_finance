import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shake/shake.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/data/models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/presentation/blocs/account_cubit.dart';
import 'package:yandex_school_finance/presentation/widgets/account_top_tile.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<AccountCubit>().loadAccount();
    _startShakeDetector();
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
          BlocBuilder<AccountCubit, AccountStateUI>(
            builder: (context, state) => switch (state) {
              LoadedState() => IconButton(
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
              ),
              _ => SizedBox.shrink(),
            },
          ),
        ],
      ),
      body: BlocConsumer<AccountCubit, AccountStateUI>(
        listener: (context, state) {
          if (state is SnackBarState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        buildWhen: (previous, current) => current is! SnackBarState,
        builder: (context, state) => switch (state) {
          InitialState() || LoadingState() => CenteredProgressIndicator(),
          LoadedState() => Column(
            children: [
              AccountTopTile(
                leadingLabel: state.account.name,
                trailingLabel: Container(
                  color: _isBalanceVisible ? Colors.transparent : Colors.black,
                  child: Text(
                    "${state.account.balance} ${state.account.currency.symbol}",
                    style: Theme.of(
                      context,
                    ).listTileTheme.leadingAndTrailingTextStyle,
                  ),
                ),
                emoji: "💰",
              ),
              AccountTopTile(
                leadingLabel: "Валюта",
                trailingLabel: Text(
                  state.account.currency.symbol,
                  style: Theme.of(
                    context,
                  ).listTileTheme.leadingAndTrailingTextStyle,
                ),
                onTap: () => _showModalBottomSheet(context),
              ),
            ],
          ),
          ErrorState() => CenteredErrorText(message: state.message),
          _ => throw UnimplementedError(state.runtimeType.toString()),
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

  void _showModalBottomSheet(BuildContext contextWithBloc) {
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
