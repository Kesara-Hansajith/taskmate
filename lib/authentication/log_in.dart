import 'package:flutter/material.dart';

import 'package:taskmate/components/auth_textfield.dart';
import 'package:taskmate/components/heading_button.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/forgot_password_hlink.dart';
import 'package:taskmate/components/external_auth_button.dart';
import 'package:taskmate/components/heading_text.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // const Image(
            //   image: AssetImage("images/TaskMateLogo_Light.png"),
            // ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: HeadingText('Welcome Back!'),
            ),
            AuthTextField("Email", false, null),
            AuthTextField("Password", true, Icons.lock),
            HeadingButton('Log In', screenWidth: screenWidth),
            const ForgotPasswordHLink('Forgot your password?', kDarkGreyColor),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                      child: Container(
                    height: 3.0,
                    width: screenWidth / 4,
                    color: kLightBlueColor,
                  )),
                  const Text(
                    'Or continue with',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  Center(
                      child: Container(
                    height: 3.0,
                    width: screenWidth / 4,
                    color: kLightBlueColor,
                  )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                ExternalAuthButton('icons/google.png', 'Google'),
                ExternalAuthButton('icons/facebook.png', 'Facebook'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Create a',
                  style: TextStyle(fontSize: 14.0),
                ),
                ForgotPasswordHLink(
                  'TaskMate',
                  kAmberColor,
                ),
                Text(
                  'Account',
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
