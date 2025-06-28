import 'package:flutter/material.dart';

class EmojiAvatar extends StatelessWidget {
  const EmojiAvatar({super.key, required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(0xffD4FAE6),
      radius: 12,
      child: Text(
        emoji,
        style: ListTileTheme.of(context).leadingAndTrailingTextStyle,
      ),
    );
  }
}
