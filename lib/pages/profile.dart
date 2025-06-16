import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_bottomsheet.dart';
import 'package:snack_swap/components/own_button.dart';
import 'package:snack_swap/components/rounded_sheet.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3B5067),
      body: SafeArea(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
            ),
            Text("Lara",
            style: Theme.of(context).textTheme.displayLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Image.asset("assets/vlags/vlag_japan.png",
                width: 30,),
                Text("Japan")
              ],
          ),
          RoundedSheet(
            color: Color(0xffF6BD78),
            child: Column(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    spacing: 20,
                    children: [
                      OwnButton(text: "My snacks",
                      backgroundColor: Color(0xff5C2E1F),
                      ),
                      OwnButton(text: "Add snack",
                      backgroundColor: Color(0xff5C2E1F),
                      ),
                    ],
                  ),
                ),
                RoundedSheet(
                  color: Color(0xff3B5067),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Succesful swaps",
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: 24
                              ),
                            ),
                            Text("6",
                             style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: 36
                              ),
                            ),
                          ],
                        ),
                      ),
                      OwnButton(text: "Sign out",
                      backgroundColor: Color(0xff5C2E1F),
                      
                      )
                    ],
                  ),
                )
              ],
            ),
          )
          ],
        )
        ),
      bottomNavigationBar: OwnBottomSheet(currentIndex: 2,
      backgroundColor: Color(0xff3B5067),
      foregroundColor: Color(0xff2B3F52),
      ),
    );
  }
}