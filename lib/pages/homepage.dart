import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    FilledButton(onPressed: (){}, child: Text("Not traded yet")),
                    FilledButton(onPressed: (){}, child: Text("Traded")),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
            ),
          )
        ],
       ),
     ),
      bottomNavigationBar: ColoredBox(
        color: Theme.of(context).colorScheme.secondary,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
            color: Theme.of(context).canvasColor
            ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 36,
            items: [
              BottomNavigationBarItem(
                label: "search",
                icon: Icon(Icons.search)
                ),
              BottomNavigationBarItem(
                label: "cookie",
                icon: Icon(Icons.cookie)
                ),
              BottomNavigationBarItem(
                label: "profile",
                icon: Icon(Icons.person)
                ),
            ],
            ),
        ),
      ),
    );
  }
}