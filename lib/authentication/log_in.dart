import 'package:flutter/material.dart';

import 'package:taskmate/components/auth_textfield.dart';
import 'package:taskmate/components/heading_button.dart';
import 'package:taskmate/constants.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: kAshWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Image(
              image: AssetImage("images/TaskMateLogo_Light.png"),
            ),
            const Text('Welcome Back!'),
            AuthTextField("Email", false, null),
            AuthTextField("Password", true, Icons.lock),
            HeadingButton('Log In',screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}
