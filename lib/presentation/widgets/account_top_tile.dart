import 'package:flutter/material.dart';

class AccountTopTile extends StatelessWidget {
  AccountTopTile({
    super.key,
    required this.leadingLabel,
    required this.trailingLabel,
    this.onTap,
    this.emoji,
    Color? tileColor,
  }) : tileColor = tileColor ?? Color(0xffD4FAE6);

  final String leadingLabel;
  final Widget trailingLabel;
  final Function()? onTap;
  final String? emoji;
  final Color tileColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: tileColor,
      title: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leadingLabel,
              style: Theme.of(context).listTileTheme.titleTextStyle,
            ),
            trailingLabel,
          ],
        ),
      ),
      leading: emoji != null
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: Text(emoji!),
            )
          : null,
      trailing: Icon(Icons.chevron_right, color: Colors.grey, size: 24),
    );
  }
}
