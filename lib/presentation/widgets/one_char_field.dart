import 'package:flutter/material.dart';

class OneCharField extends StatelessWidget {
  const OneCharField({super.key, required this.char});

  final String char;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey.shade300,
      child: Text(char, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}
