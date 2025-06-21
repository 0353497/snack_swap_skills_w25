import 'package:flutter/material.dart';
import 'package:snack_swap/pages/homepage.dart';
import 'package:snack_swap/pages/login.dart';
import 'package:snack_swap/utils/auth_bloc.dart';
import 'package:snack_swap/models/user.dart';

class Autgate extends StatefulWidget {
  const Autgate({super.key});

  @override
  State<Autgate> createState() => _AutgateState();
}

class _AutgateState extends State<Autgate> {
  final AuthBloc _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authBloc.currentUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return Scaffold(body: Center(child: CircularProgressIndicator()));
        if (snapshot.hasData && snapshot.data != null) {
          return const Homepage();
        } else {
          return const LoginPage();
        }
      }
    );
  }
}