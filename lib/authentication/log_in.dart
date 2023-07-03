import 'package:flutter/material.dart';
import 'package:taskmate/components/auth_textfield.dart';
import 'package:taskmate/components/heading_button.dart';
import 'package:taskmate/components/sign_up_hlink.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/forgot_password_hlink.dart';
import 'package:taskmate/components/external_auth_button.dart';
import 'package:taskmate/components/bottom_sub_text.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    // final double screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: kDeepBlueColor),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.asset('images/TaskMateLogo_Light.png'),
            ),
            Expanded(
              flex: 5,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/noise_image.png'),
                        repeat: ImageRepeat.repeat,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: ListView(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                'Welcome Back!',
                                textAlign: TextAlign.center,
                                style: kHeadingTextStyle,
                              ),
                            ),
                            AuthTextField("Email", false, null),
                            AuthTextField("Password", true, Icons.lock),
                            HeadingButton('Log In', screenWidth: screenWidth),
                            const ForgotPasswordHLink(
                                'Forgot your password?', kDarkGreyColor),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      height: 3.0,
                                      width: screenWidth / 4,
                                      color: kLightBlueColor,
                                    ),
                                  ),
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const <Widget>[
                                ExternalAuthButton(
                                    'icons/google.png', 'Google'),
                                ExternalAuthButton(
                                    'icons/facebook.png', 'Facebook'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                BottomSubText('Create a'),
                                SignUpHLink('TaskMate'),
                                BottomSubText('Account'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
