import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_button.dart';
import 'package:snack_swap/components/rounded_sheet.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/models/user.dart';
import 'package:snack_swap/pages/lets_swap.dart';
import 'package:snack_swap/utils/auth_bloc.dart';
import 'package:snack_swap/utils/box_manager.dart';

class ItemHighlightPage extends StatelessWidget {
  const ItemHighlightPage({super.key, required this.snack});
  final Snack snack;
  
  bool _isSnackTradable() {
    User? currentUser = AuthBloc().currentUserValue;
    if (currentUser == null) return false;
    
    if (snack.userID == currentUser.userID) return false;
    
    User? ownerUser = BoxManager.getUserWithSnack(snack);
    return ownerUser != null;
  }
  
  @override
  Widget build(BuildContext context) {
    final bool canTrade = _isSnackTradable();
    
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Theme.of(context).canvasColor,
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.maxFinite,
            child: Image.asset(snack.imageImgUrl!),
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
                    Text(snack.name,
                    style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Image.asset(snack.countryImgUrl!,
                        width: 30,),
                        Text(snack.country)
                      ],
                    ),
                    Text(
                      snack.description,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    if (canTrade)
                      OwnButton(
                        text: "Let's swap",
                        onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) => LetsSwap(wantedSnack: snack))),
                      )
                    else
                      Opacity(
                        opacity: 0.5,
                        child: OwnButton(
                          text: "Can't swap this item",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("You can't trade with yourself!"))
                            );
                          },
                        ),
                      )
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

