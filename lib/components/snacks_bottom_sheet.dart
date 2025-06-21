import 'package:flutter/material.dart';
import 'package:snack_swap/models/snack.dart';

class SnacksBottomSheet {
  static void show({
    required BuildContext context, 
    required List<Snack> snacks,
    Function(Snack)? onSnackTap,
    String title = "My Snacks",
    Color textColor = Colors.white,
    Color barColor = const Color(0xff5C2E1F),
    Color tileColor = const Color(0xff2B3F52)
  }) {
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
              color: tileColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title, 
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: textColor,),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: snacks.isEmpty
                    ? Center(child: Text("No snacks to show", 
                        style: TextStyle(color: textColor),
                      ))
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: snacks.length,
                        itemBuilder: (context, index) {
                          final Snack snack = snacks[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: onSnackTap != null ? () {
                                onSnackTap(snack);
                                Navigator.pop(context);
                              } : null,
                              child: ListTile(
                                tileColor: tileColor,
                                splashColor: tileColor,
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
                                  style: TextStyle(color: textColor),
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
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                ),
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
}