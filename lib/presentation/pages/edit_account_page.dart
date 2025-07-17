import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_school_finance/core/enums/currency_enum.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:yandex_school_finance/presentation/blocs/edit_account_cubit.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_error_text.dart';
import 'package:yandex_school_finance/presentation/widgets/centered_progress_indicator.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key, required this.id, required this.account});

  final AccountModel? account;
  final String? id;

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _balanceController;
  CurrencyEnum? _currency;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _balanceController = TextEditingController()
      ..addListener(() {
        if (_balanceController.text.isEmpty ||
            double.tryParse(_balanceController.text) == null) {
          _balanceController.text = "0";
        }
      });

    if (widget.id == null || int.tryParse(widget.id!) == null) {
      context.read<EditAccountCubit>().showError(
        AppLocalizations.of(context).incorrect_id,
      );
    } else if (widget.account != null) {
      context.read<EditAccountCubit>().showAccount(widget.account!);
    } else {
      context.read<EditAccountCubit>().loadAccountById(int.parse(widget.id!));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).my_account),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          IconButton(
            onPressed: _sendNewAccountAndClose,
            icon: Icon(Icons.done),
          ),
        ],
      ),

      body: BlocBuilder<EditAccountCubit, EditAccountUIState>(
        builder: (context, state) {
          switch (state) {
            case InitialState() || LoadingState():
              return CenteredProgressIndicator();
            case ErrorState():
              return CenteredErrorText(message: state.message(context));
            case LoadedState():
              _currency = state.accountResponseModel.currency;
              if (_nameController.text.isEmpty) {
                _nameController.text = state.accountResponseModel.name;
              }
              if (_balanceController.text.isEmpty) {
                _balanceController.text = state.accountResponseModel.balance
                    .toString();
              }
              return Column(
                spacing: 33,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Icon(Icons.person_outline),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(
                                        context,
                                      ).name,
                                    ),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    controller: _balanceController,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(
                                        context,
                                      ).balance,
                                      border: InputBorder.none,
                                      suffix: Text(
                                        state
                                            .accountResponseModel
                                            .currency
                                            .symbol,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xffE46962),
                          child: IconButton(
                            onPressed: () {
                              // Delete account, but we have only one
                            },
                            icon: Icon(Icons.delete_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffE46962),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // We have only one account, kakoy udalit
                      },
                      child: Text(AppLocalizations.of(context).remove_account),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }

  void _sendNewAccountAndClose() {
    if (Decimal.tryParse(_balanceController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).incorrect_balance_entered),
        ),
      );
      return;
    } else if (_currency == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).account_is_not_loaded),
        ),
      );
      return;
    }

    context.pop(
      AccountUpdateRequestModel(
        name: _nameController.text,
        balance: Decimal.parse(_balanceController.text),
        currency: _currency!,
      ),
    );
  }
}
