import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_bottomsheet.dart';
import 'package:snack_swap/components/rounded_sheet.dart';

class SwapsPage extends StatelessWidget {
  const SwapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5C2E1F),
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
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: OwnBottomSheet(currentIndex: 1),
    );
  }
}
