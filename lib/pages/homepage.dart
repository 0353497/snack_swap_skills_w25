import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_bottomsheet.dart';
import 'package:snack_swap/components/rounded_sheet.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBody: true,
     body: SafeArea(
       child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(24),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Snacks",
                
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.displayLarge),
                Row(
                  spacing: 16,
                  children: [
                    FilledButton(onPressed: (){}, child: Text("all")),
                    FilledButton(onPressed: null, child: Text("Not traded yet")),
                    FilledButton(onPressed: null, child: Text("Traded")),
                  ],
                )
              ],
            ),
          ),
          RoundedSheet()
        ],
       ),
     ),
      bottomNavigationBar: OwnBottomSheet(currentIndex: 0,),
    );
  }
}

