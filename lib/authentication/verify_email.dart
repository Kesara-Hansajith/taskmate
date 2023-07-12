import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: SizedBox(
        width: screenHeight,
        height: screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.asset('images/Mailbox.png'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Verify your email address',
                    style: TextStyle(
                        color: kDeepBlueColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'We have just send email verification link to your emailaddress@gmail.com.',
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Please check email and click on the link provided to verify your address.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            //"Go to Email Inbox" button goes here
            Container(
              width: screenWidth,
              //Margin of the button
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDeepBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Go to Email Inbox',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'If you haven’t received the link yet, please click on resend button',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //"Resend" button goes here
                  Container(
                    width: screenWidth,
                    //Margin of the button
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 28.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kOceanBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Resend',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: kDeepBlueColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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
