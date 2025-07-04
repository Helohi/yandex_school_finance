import 'package:flutter/material.dart';

class BackgroundBarrier extends StatelessWidget {
  const BackgroundBarrier({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        child,
      ],
    );
  }
}
