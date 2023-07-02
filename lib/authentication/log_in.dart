import 'package:flutter/material.dart';

import 'package:taskmate/components/auth_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe7edf0),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Image(
              image: AssetImage("images/TaskMateLogo_Light.png"),
            ),
            Text('Welcome Back!'),
            AuthTextField("Email", false, null),
            AuthTextField("Password", true, Icons.lock),
          ],
        ),
      ),
    );
  }
}
