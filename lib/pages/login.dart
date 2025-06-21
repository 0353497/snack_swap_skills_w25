import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_button.dart';
import 'package:snack_swap/utils/box_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/logo_secondary.png"),
            Form(
              child: Column(
                spacing: 10,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("name",
                      style: TextStyle(
                        color: Color(0xffFFF3E2),
                        fontSize: 16
                      ),
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                           enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color(0xffFFA87C),
                              width: 2
                            )
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color(0xffFFA87C),
                              width: 2
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("password",
                       style: TextStyle(
                        color: Color(0xffFFF3E2),
                        fontSize: 16
                      ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color(0xffFFA87C),
                              width: 2
                            )
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color(0xffFFA87C),
                              width: 2
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                 OwnButton(
                  backgroundColor: Color(0xffFFA87C),
                  text: "Submit", onTap: () async {
                    final String name = nameController.value.text.trim();
                    final String password = passwordController.value.text.trim();
                    try {
                      await BoxManager.login(name, password);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString()))
                      );
                    }
                  }
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}