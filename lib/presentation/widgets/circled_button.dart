import 'package:flutter/material.dart';

class CircledButton extends StatelessWidget {
  const CircledButton({super.key, this.onPressed, required this.child});

  final Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: CircleAvatar(
          backgroundColor: Colors.blueGrey.shade50,
          radius: 48,
          child: child,
        ),
      ),
    );
  }
}
