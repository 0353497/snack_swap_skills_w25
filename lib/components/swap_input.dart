
import 'package:flutter/material.dart';

class SwapInput extends StatelessWidget {
  const SwapInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blueAccent
            ),
        ),
        SizedBox(
          width: 80,
          child: Text(
            "Poky sticks",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 24
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}