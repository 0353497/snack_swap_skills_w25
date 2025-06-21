import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_button.dart';
import 'package:snack_swap/components/rounded_sheet.dart';
import 'package:snack_swap/components/snacks_bottom_sheet.dart';
import 'package:snack_swap/components/swap_input.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/models/user.dart';
import 'package:snack_swap/utils/box_manager.dart';

class LetsSwap extends StatefulWidget {
  const LetsSwap({super.key, required this.wantedSnack});
  final Snack wantedSnack;

  @override
  State<LetsSwap> createState() => _LetsSwapState();
}

class _LetsSwapState extends State<LetsSwap> {
  late final User? userWithWantedSnack;
  Snack? selectedUserSnack;

  @override
  void initState() {
    super.initState();
    userWithWantedSnack = BoxManager.getUserWithSnack(widget.wantedSnack);
  }
  
  void _showUserSnackSelection() {
    final userSnacks = BoxManager.getCurrentUserSnacks();
    
    SnacksBottomSheet.show(
      context: context,
      snacks: userSnacks,
      title: "Select Your Snack",
      onSnackTap: (snack) {
        setState(() {
          selectedUserSnack = snack;
        });
      },
      barColor: Theme.of(context).colorScheme.secondary,
      tileColor: Theme.of(context).colorScheme.primary,
      textColor: Color(0xff2B3F52)
    );
  }

  void _sendTradeRequest() {
    if (selectedUserSnack == null || userWithWantedSnack == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a snack to trade'))
      );
      return;
    }
    
    final currentUser = BoxManager.getUserWithSnack(selectedUserSnack!);
    if (currentUser == null) return;
    
    BoxManager.createTrade(
      currentUser, 
      selectedUserSnack!, 
      userWithWantedSnack!, 
      widget.wantedSnack
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Trade request sent!'))
    );
    
    Navigator.pop(context);
  }

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
                  Text("Swap with ${userWithWantedSnack!.name}",
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
                          children: [
                            SwapInput(highligtedSnack: widget.wantedSnack),
                            GestureDetector(
                              onTap: _showUserSnackSelection,
                              child: SwapInput(highligtedSnack: selectedUserSnack),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          height: 100,
                          child: Image.asset("assets/arrows/arrow_left.png"),
                        ),
                        OwnButton(
                          text: "Send request",
                          onTap: _sendTradeRequest
                        )
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
