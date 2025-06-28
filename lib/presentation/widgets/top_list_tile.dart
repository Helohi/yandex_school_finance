import 'package:flutter/material.dart';

class TopListTile extends StatelessWidget {
  const TopListTile({
    super.key,
    required this.title,
    required this.trailing,
    this.onTap,
    this.leading,
  });

  final String title;
  final Widget trailing;
  final Widget? leading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffD4FAE6),
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: ListTile(
        leading: leading,
        title: Text(title),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
