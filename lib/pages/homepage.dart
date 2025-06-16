import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_bottomsheet.dart';
import 'package:snack_swap/components/rounded_sheet.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/utils/box_manager.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Snack> snacks = BoxManager.getAllUniqueSnacks();

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
          RoundedSheet(
            child: Padding(
              padding: EdgeInsetsGeometry.all(8),
              child: Expanded(
                child: ListView.builder(
                  itemCount: snacks.length + 1,
                  itemBuilder: (context, int i) {
                    if (i == 0) {
                      return  SearchBar(
                        hintText: "Search a snack...",
                        onChanged: (value) {
                        },
                      );
                    }
                    final Snack snack = snacks[i -1];
                     if (snack.imageImgUrl == null) {
                         return ListTile(
                          title: Text(snack.name),
                          subtitle: Text(snack.description),
                        );
                      } else {
                      return SnackListTile(snack: snack, index: i);
                      }
                    }
                  ),
              ),
              ),
          )
        ],
       ),
     ),
      bottomNavigationBar: OwnBottomSheet(currentIndex: 0,),
    );
  }
}

class SnackListTile extends StatelessWidget {
  SnackListTile({
    super.key,
    required this.snack,
    this.index
  });

  final Snack snack;
  final int? index;

  @override
  Widget build(BuildContext context) {
  final List<Color> itemColors = [Color(0xffDC6B32), Color(0xffF6D097)];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: index != null ?
              itemColors[index! % itemColors.length]
              : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(16)
            ),
            width: 100,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage(snack.imageImgUrl!),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25,),
                Text(
                  snack.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (snack.countryImgUrl != null)
                      Image.asset(
                        snack.countryImgUrl!,
                        height: 30,
                        width: 30,
                      ),
                    SizedBox(width: 10),
                    Text(snack.country),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

