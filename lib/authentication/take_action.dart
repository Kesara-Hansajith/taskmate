import 'package:flutter/material.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Take Action & Open Your Account',
              textAlign: TextAlign.center,
              style: kHeadingTextStyle,
            ),
          ),
          UserTypeSelector('I want to work', screenWidth: screenWidth),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Or',
              style: TextStyle(
                  color: kDarkGreyColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          UserTypeSelector('I want to hire', screenWidth: screenWidth),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const BottomSubText("Already registered?"),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    color: kAmberColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


