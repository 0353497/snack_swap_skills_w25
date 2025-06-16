import 'package:flutter/material.dart';

class OwnButton extends StatelessWidget {
  const OwnButton({
    super.key, required this.text, this.backgroundColor, required this.onTap,
  });
  final String text;
  final Color? backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: FilledButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ??
            Theme.of(context).canvasColor
            )
        ),
        child: Text(
          text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xffFFF3E2)
        ),
        )
      )
    );
  }
}