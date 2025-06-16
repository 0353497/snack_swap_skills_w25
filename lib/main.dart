import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snack_swap/pages/homepage.dart';
import 'package:snack_swap/utils/theme.dart';
void main() async{
  await Hive.initFlutter();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MainTheme.mainThemeData,
      home: Homepage()
    );
  }
}
