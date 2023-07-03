import 'package:flutter/material.dart';
import 'package:taskmate/components/sign_up_hlink.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/heading_button.dart';
import 'package:taskmate/components/bottom_sub_text.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Image(
                          image: AssetImage('gifs/rocket_man.gif'),
                        ),
                        HeadingButton('Get Started', screenWidth: screenWidth),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            BottomSubText('New to TaskMate?'),
                            SignUpHLink('Sign Up'),
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
