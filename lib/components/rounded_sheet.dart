import 'package:flutter/material.dart';

class RoundedSheet extends StatelessWidget {
  const RoundedSheet({
    super.key, this.child, this.color,
  });
  final Widget? child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: child,
      ),
    );
  }
}
