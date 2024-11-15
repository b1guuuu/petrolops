import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final double? minWidth;

  const BaseButton({super.key, this.onPressed, this.minWidth, this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: minWidth,
      color: Colors.blueAccent,
      textColor: Colors.white,
      elevation: 1,
      enableFeedback: true,
      child: child,
    );
  }
}
