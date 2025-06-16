import 'package:flutter/material.dart';
import 'package:snack_swap/pages/homepage.dart';
import 'package:snack_swap/utils/theme.dart';
void main() {
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
