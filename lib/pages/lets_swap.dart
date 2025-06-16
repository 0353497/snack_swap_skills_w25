import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_button.dart';
import 'package:snack_swap/components/rounded_sheet.dart';
import 'package:snack_swap/components/swap_input.dart';

class LetsSwap extends StatelessWidget {
  const LetsSwap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox( height: 30,),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text("Let's swap",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          RoundedSheet(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Swap with Yui",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 100,
                          child: Image.asset("assets/arrows/arrow_right.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            SwapInput(),
                            SwapInput(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          height: 100,
                          child: Image.asset("assets/arrows/arrow_left.png"),
                        ),
                        OwnButton(text: "Send request",onTap: (){})
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
