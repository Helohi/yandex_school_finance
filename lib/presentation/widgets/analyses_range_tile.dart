import 'package:flutter/material.dart';
import 'package:yandex_school_finance/core/extensions/date_to_string.dart';

class AnalysesRangeTile extends StatelessWidget {
  const AnalysesRangeTile({
    super.key,
    required this.title,
    required this.dateToShow,
    this.onPressed,
  });

  final String title;
  final DateTime dateToShow;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: ElevatedButton(
        onPressed: onPressed,
        child: Text(dateToShow.toHumanString()),
      ),
    );
  }
}
