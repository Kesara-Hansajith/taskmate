import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/constants.dart';

class VerificationFailed extends StatefulWidget {
  const VerificationFailed({super.key});

  @override
  State<VerificationFailed> createState() => _VerificationFailedState();
}

class _VerificationFailedState extends State<VerificationFailed> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'images/noise_image.webp',
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('gifs/failed.gif'),
              ),
              const Padding(
                padding:  EdgeInsets.symmetric(vertical: 16.0),
                child:  Text(
                  'Sorry!\nWe can\'t verify you!',
                  textAlign: TextAlign.center,
                  style: kSubHeadingTextStyle,
                ),
              ),
              SizedBox(
                width: screenWidth,
                child: DarkMainButton(
                    title: 'Close',
                    process: () {
                      SystemNavigator.pop();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
