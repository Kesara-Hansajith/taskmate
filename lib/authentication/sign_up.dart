import 'package:flutter/material.dart';
import 'package:taskmate/components/log_in_hlink.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/external_auth_button.dart';
import 'package:taskmate/components/bottom_sub_text.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: kAshWhiteColor,
      body: Container(
        decoration: const BoxDecoration(color: kDeepBlueColor),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.asset('images/TaskMateLogo_Light.png'),
            ),
            Expanded(
              flex: 3,
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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 16.0,
                              ),
                              child: Text(
                                'Sign up & Find Your Next Gig',
                                textAlign: TextAlign.center,
                                style: kHeadingTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 24.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kDeepBlueColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.person_add,
                                        color: kBrilliantWhite,
                                      ),
                                      Text(
                                        'Continue with Email or Mobile',
                                        style: TextStyle(
                                            color: kBrilliantWhite, fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                ExternalAuthButton('icons/google.png', 'Google'),
                                ExternalAuthButton(
                                    'icons/facebook.png', 'Facebook'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                BottomSubText('Already registered?'),
                                LogInHLink('Log In'),
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
