// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class BackFloatingActionButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final void Function() onPressed;
  const BackFloatingActionButtonWidget({
    super.key,
    required this.backgroundColor,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 100,
          ),
          child: FloatingActionButton(
            backgroundColor: backgroundColor,
            onPressed: onPressed,
            child: child,
          ),
        ),
      ],
    );
  }
}
