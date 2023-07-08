import 'package:flutter/material.dart';
import 'package:taskmate/authentication/sign_up.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/bottom_sub_text.dart';
import 'package:taskmate/authentication/root_page.dart';

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
              flex: 3,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          //GIF will goes here
                          const Image(
                            image: AssetImage('gifs/rocket_man.gif'),
                          ),
                          //"Get Started" will goes here
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
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const RootPage(),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Get Started!',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ),
                          ),
                          //Bottom most row of screen
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //"New to TaskMate text will goes here"
                              const BottomSubText('New to TaskMate?'),
                              //"Sign Up" button will goes here
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: kAmberColor,
                                  ),
                                ),
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
