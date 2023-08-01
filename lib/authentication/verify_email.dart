import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.width;
    final double screenWidth = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              repeat: ImageRepeat.repeat,
              image: AssetImage('images/noise_image.png'),
            ),
          ),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                child: Text(
                  'Verify Your Email Address',
                  textAlign: TextAlign.center,
                  style: kHeadingTextStyle,
                ),
              ),
              const Expanded(
                flex: 8,
                child: Image(
                  image: AssetImage('images/mailbox.webp'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
