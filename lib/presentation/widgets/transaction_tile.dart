import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yandex_school_finance/presentation/widgets/emoji_avatar.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transactionCategoryName,
    required this.transactionAmount,
    this.transactionComment,
    this.emoji,
    this.time,
    this.onTap,
  });

  final String transactionCategoryName;
  final String transactionAmount;
  final String? transactionComment;
  final String? emoji;
  final String? time;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(transactionCategoryName),
      subtitle: transactionComment != null ? Text(transactionComment!) : null,
      leading: emoji != null ? EmojiAvatar(emoji: emoji!) : null,
      trailing: TextButton.icon(
        onPressed: null,
        iconAlignment: IconAlignment.end,
        icon: Icon(CupertinoIcons.right_chevron),
        label: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Text(transactionAmount), if (time != null) Text(time!)],
          ),
        ),
      ),
    );
  }
}
