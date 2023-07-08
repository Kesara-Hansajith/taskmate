import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/components/auth_textfield.dart';
import 'package:taskmate/components/heading_button.dart';
import 'package:taskmate/components/sign_up_hlink.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/forgot_password_hlink.dart';
import 'package:taskmate/components/external_auth_button.dart';
import 'package:taskmate/components/bottom_sub_text.dart';
import 'package:taskmate/authentication/get_started.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  // void dispose(){
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  Future<void> _login(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Authentication successful, navigate to the new page
      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(
            context, 'lib/authentication/get_started.dart');
      }
    } catch (e) {
      // Handle authentication errors
      print('Authentication failed: $e');
    }
  }

// Future signIn() async {
  //   FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: emailController.text.trim(),
  //     password: passwordController.text.trim(),
  //
  //   );
  // }

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
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 28.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: kBrilliantWhite,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextField(
                                controller: emailController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 28.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: kBrilliantWhite,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.lock,
                                      color: kJetBlack,
                                    ),
                                    //todo: Functionality for the Password Section Obsecure text availability
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 28.0),
                              width: screenWidth,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kDeepBlueColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  _login(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Log In',
                                    style: const TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ),
                            ),
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
