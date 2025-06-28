import 'package:flutter/material.dart';

class CenteredErrorText extends StatelessWidget {
  const CenteredErrorText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red, fontSize: 24.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
