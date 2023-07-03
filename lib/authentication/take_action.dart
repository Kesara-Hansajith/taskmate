import 'package:flutter/material.dart';
import 'package:taskmate/components/log_in_hlink.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/user_type_selector.dart';
import 'package:taskmate/components/bottom_sub_text.dart';

class TakeAction extends StatelessWidget {
  const TakeAction({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    //final double screenHeight = screenSize.height;

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
                                horizontal: 8.0,
                              ),
                              child: Text(
                                'Take Action & Open Your Account',
                                textAlign: TextAlign.center,
                                style: kHeadingTextStyle,
                              ),
                            ),
                            UserTypeSelector('I want to work',
                                screenWidth: screenWidth),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Or',
                                style: TextStyle(
                                    color: kDarkGreyColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            UserTypeSelector('I want to hire',
                                screenWidth: screenWidth),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                BottomSubText("Already registered?"),
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
