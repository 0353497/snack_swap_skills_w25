
import 'package:flutter/material.dart';
import 'package:snack_swap/models/snack.dart';

class SwapInput extends StatelessWidget {
  const SwapInput({
    super.key, required this.highligtedSnack,
  });
  final Snack? highligtedSnack;

  @override
  Widget build(BuildContext context) {




    if (highligtedSnack == null) {
      return Column(
        children: [
            InkWell(
              child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xffF6D097)
              ),
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(height: 30,)
        ],
      );
    }
    

    return Column(
      children: [
        Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xffF6D097)
            ),
            child: Image.asset(highligtedSnack!.imageImgUrl!),
        ),
        SizedBox(
          width: 80,
          child: Text(
            highligtedSnack!.name,
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