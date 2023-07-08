import 'package:flutter/material.dart';
import 'package:taskmate/authentication/sign_up.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/components/bottom_sub_text.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obsecureController = true;

  void setObsecure() {
    setState(() {
      obsecureController = !obsecureController;
    });
  }

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
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    bottom: 0,
                    child: Container(
                      width: screenWidth,
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
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Welcome Back!',
                                  style: kHeadingTextStyle,
                                ),
                              ),
                              //Email Textfield
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 28.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: kBrilliantWhite,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child:
                                    //Email Textfield
                                    TextField(
                                  controller: emailController,
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                  ),
                                ),
                              ),
                              //Password Textfield
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 28.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: kBrilliantWhite,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child:
                                    //Password Textfield
                                    TextField(
                                  controller: passwordController,
                                  obscureText: obsecureController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: obsecureController
                                          ? const Icon(Icons.lock)
                                          : const Icon(Icons.lock_open),
                                      color: kJetBlack,
                                      onPressed: () {
                                        setObsecure();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              //"Log In Button goes here"
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
                                  onPressed: () {},
                                  //TODO: Implement Login action with firebase
                                  child: const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Log In',
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                //TODO: Implement Forgot Password Section
                                onPressed: () {},
                                child: const Text(
                                  'Forgot your Password',
                                  style: TextStyle(
                                    color: kDarkGreyColor,
                                  ),
                                ),
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  //"Google" Signup Button
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 24.0),
                                        backgroundColor: kLightBlueColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            'icons/google.png',
                                            width: 25.0,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          const Text(
                                            'Google',
                                            style: TextStyle(
                                                color: kDeepBlueColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //"Facebook" Signup Button
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 24.0),
                                        backgroundColor: kLightBlueColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            'icons/facebook.png',
                                            width: 25.0,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          const Text(
                                            'Facebook',
                                            style: TextStyle(
                                                color: kDeepBlueColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const BottomSubText('Create a'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const SignUp(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'TaskMate',
                                      style: TextStyle(
                                        color: kAmberColor,
                                      ),
                                    ),
                                  ),
                                  const BottomSubText('Account'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
