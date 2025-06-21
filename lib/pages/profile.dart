import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_bottomsheet.dart';
import 'package:snack_swap/components/own_button.dart';
import 'package:snack_swap/components/rounded_sheet.dart';
import 'package:snack_swap/data/seedingdata.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/utils/auth_bloc.dart';
import 'package:snack_swap/utils/box_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final items = BoxManager.getCurrentUserSnacks();
  final user = AuthBloc().currentUserValue;

  void _showSnacksBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xff2B3F52),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff5C2E1F),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Snacks", 
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white,),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: items.isEmpty
                    ? Center(child: Text("No snacks to show", 
                        style: TextStyle(color: Colors.white),
                      ))
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final Snack snack = items[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor: Color(0xff2B3F52),
                              splashColor: Color(0xff2B3F52),
                              leading: Container(
                                width: 60,
                                height: 60,
                                color: Color(0xffF6BD78),
                                child: snack.imageImgUrl != null
                                  ? Image.asset(
                                      snack.imageImgUrl!,
                                      fit: BoxFit.contain,
                                    )
                                  : null,
                              ),
                              title: Text(snack.name,
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (snack.countryImgUrl != null)
                                    Image.asset(
                                      snack.countryImgUrl!,
                                      width: 20,
                                      height: 20,
                                    ),
                                  SizedBox(width: 8),
                                  Text(snack.country,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

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
              backgroundImage: user?.profileImg != null ? AssetImage(user!.profileImg!) : null,
              child: Icon(Icons.person, size: 150,),
            ),
            Text(user!.name,
            style: Theme.of(context).textTheme.displayLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Image.asset(user!.countryImgUrl!,
                width: 30,),
                Text(user!.country,
                style: TextStyle(
                  color: Colors.white
                ),
                )
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
                        OwnButton(text: "My snacks (${items.length})",
                        onTap: _showSnacksBottomSheet,
                        backgroundColor: Color(0xff5C2E1F),
                        ),
                        OwnButton(text: "Add snack",
                        onTap: () {
                        },
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
                        onTap: () => BoxManager.logout(),
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