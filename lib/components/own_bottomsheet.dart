
import 'package:flutter/material.dart';
import 'package:snack_swap/pages/homepage.dart';
import 'package:snack_swap/pages/profile.dart';
import 'package:snack_swap/pages/swaps.dart';

class OwnBottomSheet extends StatelessWidget {
  const OwnBottomSheet({
    super.key, required this.currentIndex, this.backgroundColor, this.foregroundColor,
  });
  final int currentIndex;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
      child: Container(
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
          color: foregroundColor ?? Theme.of(context).canvasColor
          ),
        child: BottomNavigationBar(
          backgroundColor: foregroundColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 36,
          currentIndex: currentIndex,
          onTap: (value) {
            if (value == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Homepage()));
            } else if (value == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SwapsPage()));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
            }
          },
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
    );
  }
}