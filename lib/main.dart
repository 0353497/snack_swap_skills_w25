import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snack_swap/models/country.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/models/trade.dart';
import 'package:snack_swap/models/user.dart';
import 'package:snack_swap/pages/autgate.dart';
import 'package:snack_swap/pages/homepage.dart';
import 'package:snack_swap/utils/box_manager.dart';
import 'package:snack_swap/utils/theme.dart';

void main() async{
  await Hive.initFlutter();
  
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SnackAdapter());
  Hive.registerAdapter(TradeAdapter());
  Hive.registerAdapter(CountryAdapter());

  await BoxManager.init();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MainTheme.mainThemeData,
      home: Autgate()
    );
  }
}
