import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_button.dart';
import 'package:snack_swap/components/rounded_sheet.dart';

class ItemHighlightPage extends StatelessWidget {
  const ItemHighlightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Theme.of(context).canvasColor,
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.maxFinite,
            // child: Image.asset(""),
          ),
          SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.5,
            child: RoundedSheet(
              child: Padding(
                padding: EdgeInsetsGeometry.all(24),
                child: Column(
                  spacing: 30,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pocky Sticks",
                    style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Image.asset("assets/vlags/vlag_japan.png",
                        width: 30,),
                        Text("Japan")
                      ],
                    ),
                    Text(
                      "dit is gewoon een test maar ik moet heel wat text hier neerzetten dus idj wtf ik aan het doen ben hallo wereld. dit is nog meer text.",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    OwnButton(text: "Let's swap")
                  ],
                ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}

