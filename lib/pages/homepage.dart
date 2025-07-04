import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_bottomsheet.dart';
import 'package:snack_swap/components/rounded_sheet.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/pages/item_highlight_page.dart';
import 'package:snack_swap/utils/box_manager.dart';

enum FilterType {
  all,
  notTraded,
  traded
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FilterType _currentFilter = FilterType.all;
  String _searchQuery = "";
  List<Snack> snacks = [];
  List<Snack> filteredSnacks = [];

  @override
  void initState() {
    super.initState();
    snacks = BoxManager.getAllUniqueSnacks();
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      filteredSnacks = snacks.where((snack) {
        bool matchesSearch = _searchQuery.isEmpty || 
          snack.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          snack.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          snack.country.toLowerCase().contains(_searchQuery.toLowerCase());

        bool matchesFilter = true;
        if (_currentFilter == FilterType.notTraded) {
          matchesFilter = !snack.hasCurrentUserTraded;
        } else if (_currentFilter == FilterType.traded) {
          matchesFilter = snack.hasCurrentUserTraded;
        }
        
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBody: true,
     body: SafeArea(
       child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Snacks",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 16),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _currentFilter = FilterType.all;
                          _applyFilters();
                        });
                      }, 
                      style: _currentFilter == FilterType.all ? null : FilledButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black54,
                      ),
                      child: const Text("All")
                    ),
                    const SizedBox(width: 16),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _currentFilter = FilterType.notTraded;
                          _applyFilters();
                        });
                      }, 
                      style: _currentFilter == FilterType.notTraded ? null : FilledButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black54,
                      ),
                      child: const Text("Not traded yet")
                    ),
                    const SizedBox(width: 16),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _currentFilter = FilterType.traded;
                          _applyFilters();
                        });
                      }, 
                      style: _currentFilter == FilterType.traded ? null : FilledButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black54,
                      ),
                      child: const Text("Traded")
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: RoundedSheet(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: filteredSnacks.length + 1,
                  itemBuilder: (context, int i) {
                    if (i == 0) {
                      return SearchBar(
                        elevation: WidgetStatePropertyAll(0),
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        hintText: "Search a snack...",
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                            _applyFilters();
                          });
                        },
                      );
                    }
                    final Snack snack = filteredSnacks[i - 1];
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
      bottomNavigationBar: const OwnBottomSheet(currentIndex: 0,),
    );
  }
}

class SnackListTile extends StatelessWidget {
  const SnackListTile({
    super.key,
    required this.snack,
    this.index
  });

  final Snack snack;
  final int? index;

  @override
  Widget build(BuildContext context) {
  final List<Color> itemColors = [Color(0xffDC6B32), Color(0xffF6D097)];
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ItemHighlightPage(snack: snack,))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                if (snack.hasCurrentUserTraded)
                Positioned(
                  top: 67.5,
                  left: 12.5,
                  child: Container(
                    width: 75,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Color(0xff4C6C82),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "Traded",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                  ),
                )
              ],
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
      ),
    );
  }
}

