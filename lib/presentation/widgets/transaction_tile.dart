import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yandex_school_finance/core/extenstions/number_formatting.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile(this.transaction, {super.key, required this.showEmoji});

  final bool showEmoji;

  final TransactionResponseModel transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transaction.category.name),
      subtitle: transaction.comment != null ? Text(transaction.comment!) : null,
      leading: showEmoji
          ? CircleAvatar(
              backgroundColor: Color(0xffD4FAE6),
              radius: 12,
              child: Text(
                transaction.category.emoji,
                style: ListTileTheme.of(context).leadingAndTrailingTextStyle,
              ),
            )
          : null,
      trailing: TextButton.icon(
        onPressed: null,
        iconAlignment: IconAlignment.end,
        icon: Icon(CupertinoIcons.right_chevron),
        label: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Text("${transaction.amount.toDouble().formatWithSpaces()} ₽"),
        ),
      ),
    );
  }
}
