import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_school_finance/core/extensions/date_to_string.dart';
import 'package:yandex_school_finance/core/service_locator.dart' show sl;
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_brief_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/presentation/blocs/edit_transaction_cubit.dart';
import 'package:yandex_school_finance/presentation/widgets/account_top_tile.dart';
import 'package:yandex_school_finance/presentation/widgets/background_barrier.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_progress_indicator.dart';

class EditTransactionDialog extends StatelessWidget {
  const EditTransactionDialog({
    super.key,
    required this.isIncome,
    this.transaction,
  });

  final bool isIncome;
  final TransactionResponseModel? transaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTransactionCubit(sl(), sl(), sl()),
      child: _BlocedEditTransactionDialog(
        key: key,
        isIncome: isIncome,
        transaction: transaction,
      ),
    );
  }
}

class _BlocedEditTransactionDialog extends StatefulWidget {
  const _BlocedEditTransactionDialog({
    super.key,
    required this.isIncome,
    this.transaction,
  });

  final bool isIncome;
  final TransactionResponseModel? transaction;

  @override
  State<_BlocedEditTransactionDialog> createState() =>
      _BlocedEditTransactionDialogState();
}

class _BlocedEditTransactionDialogState
    extends State<_BlocedEditTransactionDialog> {
  bool _showOverflowLoading = false;

  AccountBriefModel? _chosenAccount;
  CategoryModel? _chosenCategory;
  late final TextEditingController _amountController;
  late DateTime _chosenDate;
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _chosenAccount = widget.transaction?.account;
    _chosenCategory = widget.transaction?.category;
    _amountController = TextEditingController(
      text: widget.transaction?.amount.toString() ?? "0",
    )..addListener(_noEmptyAndLeadingZeros);
    _chosenDate = widget.transaction?.transactionDate ?? DateTime.now();
    _commentController = TextEditingController(
      text: widget.transaction?.comment,
    );

    context.read<EditTransactionCubit>().loadAll(widget.isIncome);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTransactionCubit, EditTransactionUIState>(
      listenWhen: (previous, current) => current is TransactionStates,
      listener: (context, state) {
        if (state is! TransactionStates) return;
        switch (state) {
          case TransactionEditLoadingState():
            setState(() {
              _showOverflowLoading = true;
            });
          case TransactionEditSuccessfully():
            setState(() {
              _showOverflowLoading = false;
            });
            Navigator.pop(context, true);
          case TransactionEditError():
            setState(() {
              _showOverflowLoading = false;
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message(context))));
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                widget.isIncome
                    ? AppLocalizations.of(context).my_incomes
                    : AppLocalizations.of(context).my_outcomes,
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
              ),
              actions: [
                IconButton(
                  onPressed: transactionFinished,
                  icon: Icon(Icons.done),
                ),
              ],
            ),
            body: Column(
              children: [
                /// account
                AccountTopTile(
                  tileColor: Colors.white,
                  leadingLabel: AppLocalizations.of(context).account,
                  trailingLabel:
                      BlocBuilder<EditTransactionCubit, EditTransactionUIState>(
                        buildWhen: (previous, current) =>
                            current is AccountUIStates,
                        builder: (context, state) {
                          if (state is! AccountUIStates) {
                            return SizedBox.shrink();
                          }
                          return switch (state) {
                            AccountsLoadingState() =>
                              const CircularProgressIndicator(),
                            AccountsErrorState() => Text(
                              state.message(context),
                            ),
                            AccountsLoadedState() =>
                              DropdownButton<AccountBriefModel>(
                                iconSize: 0.0,
                                underline: const SizedBox.shrink(),
                                alignment: Alignment.centerRight,
                                hint: Text(
                                  AppLocalizations.of(context).not_chosen,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                items: List.generate(
                                  state.accounts.length,
                                  (index) => DropdownMenuItem(
                                    value: state.accounts[index],
                                    child: Text(state.accounts[index].name),
                                  ),
                                ),
                                value: _chosenAccount,
                                onChanged: (value) =>
                                    setState(() => _chosenAccount = value),
                              ),
                          };
                        },
                      ),
                ),

                /// category
                AccountTopTile(
                  tileColor: Colors.white,
                  leadingLabel: AppLocalizations.of(context).category,
                  trailingLabel:
                      BlocBuilder<EditTransactionCubit, EditTransactionUIState>(
                        buildWhen: (previous, current) =>
                            current is CategoryUIStates,
                        builder: (context, state) {
                          if (state is! CategoryUIStates) {
                            return SizedBox.shrink();
                          }
                          return switch (state) {
                            CategoriesLoadingState() =>
                              const CircularProgressIndicator(),
                            CategoriesErrorState() => Text(
                              state.message(context),
                            ),
                            CategoriesLoadedState() =>
                              DropdownButton<CategoryModel>(
                                iconSize: 0.0,
                                underline: const SizedBox.shrink(),
                                alignment: Alignment.centerRight,
                                hint: Text(
                                  AppLocalizations.of(context).not_chosen,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                items: List.generate(
                                  state.categories.length,
                                  (index) => DropdownMenuItem(
                                    value: state.categories[index],
                                    child: Text(state.categories[index].name),
                                  ),
                                ),
                                value: _chosenCategory,
                                onChanged: (value) =>
                                    setState(() => _chosenCategory = value),
                              ),
                          };
                        },
                      ),
                ),

                /// amount
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context).total),
                      SizedBox(width: 16),
                      Flexible(
                        child: TextField(
                          onTap: () => _amountController.selection =
                              TextSelection.collapsed(
                                offset: _amountController.text.length,
                              ),
                          textAlign: TextAlign.end,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffix: Text(
                              _chosenAccount?.currency.symbol ?? "₽",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// transactionDate
                ListTile(
                  onTap: _showDatePicker,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context).date),
                      Text(_chosenDate.toHumanString()),
                    ],
                  ),
                ),

                ListTile(
                  onTap: _showTimePicker,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context).time),
                      Text(
                        "${_chosenDate.hour.toString().padLeft(2, '0')}:${_chosenDate.minute.toString().padLeft(2, '0')}",
                      ),
                    ],
                  ),
                ),

                /// comment
                ListTile(
                  title: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context).comment,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

                /// remove transaction
                if (widget.transaction != null)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 32,
                      left: 16,
                      right: 16,
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (widget.transaction != null) {
                          context
                              .read<EditTransactionCubit>()
                              .deleteTransaction(widget.transaction!.id);
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context).remove_transaction,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          if (_showOverflowLoading)
            BackgroundBarrier(child: const CenteredProgressIndicator()),
        ],
      ),
    );
  }

  void _noEmptyAndLeadingZeros() {
    if (_amountController.text.isEmpty ||
        Decimal.tryParse(_amountController.text) == null) {
      _amountController.text = "0";
    } else if (_amountController.text.length > 1 &&
        _amountController.text.startsWith("0")) {
      _amountController.text = _amountController.text.substring(1);
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDate: _chosenDate,
    ).then(
      (date) => setState(
        () => _chosenDate =
            date?.copyWith(
              hour: _chosenDate.hour,
              minute: _chosenDate.minute,
            ) ??
            _chosenDate,
      ),
    );
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_chosenDate),
    ).then(
      (value) => setState(
        () => _chosenDate = _chosenDate.copyWith(
          hour: value?.hour ?? _chosenDate.hour,
          minute: value?.minute ?? _chosenDate.minute,
        ),
      ),
    );
  }

  void transactionFinished() {
    if (_chosenAccount == null ||
        _chosenCategory == null ||
        Decimal.tryParse(_amountController.text) == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.red,
          title: Text(AppLocalizations.of(context).fill_all_fields),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context).ok),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
      return;
    }

    final transactionRequest = TransactionRequestModel(
      accountId: _chosenAccount!.id,
      categoryId: _chosenCategory!.id,
      amount: Decimal.parse(_amountController.text),
      transactionDate: _chosenDate,
      comment: _commentController.value.text.isEmpty
          ? null
          : _commentController.value.text,
    );

    if (widget.transaction != null) {
      context.read<EditTransactionCubit>().updateTransaction(
        widget.transaction!.id,
        transactionRequest,
      );
    } else {
      context.read<EditTransactionCubit>().createTransaction(
        transactionRequest,
      );
    }
  }
}
