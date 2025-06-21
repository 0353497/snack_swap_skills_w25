import 'package:flutter/material.dart';
import 'package:snack_swap/pages/homepage.dart';
import 'package:snack_swap/pages/login.dart';
import 'package:snack_swap/utils/auth_bloc.dart';

class Autgate extends StatelessWidget {
  const Autgate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthBloc().currentUser,
      builder: (context, snapshot) {

        debugPrint(snapshot.data.toString());
        if (snapshot.data != null) {
          return Homepage();
        } else {
          return LoginPage();
        }
      }
      );
  }
}