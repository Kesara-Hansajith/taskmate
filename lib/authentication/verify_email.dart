import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:taskmate/components/snackbar.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  String? _email;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      _email = user.email!;
    }
    super.initState();
  }

//Will send the verification mail again
  Future<void> resendVerificationLink() async {
    final user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar('Verification link was sent'),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar('No user found'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          // height: screenHeight,
          // width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              repeat: ImageRepeat.repeat,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                child: Text(
                  'Verify Your Email Address',
                  textAlign: TextAlign.center,
                  style: kHeadingTextStyle.copyWith(height: 1.2),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Image(
                  image: AssetImage('images/mailbox.webp'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'We have just send email verification link to your ',
                      style: kTextStyle,
                    ),
                    Text(
                      '$_email',
                      style: kTextStyle.copyWith(color: kDeepBlueColor),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Please check email and click on the link provided to verify your address.',
                      textAlign: TextAlign.center,
                      style: kTextStyle,
                    ),
                    const SizedBox(height: 10.0,),
                    DarkMainButton(
                        title: 'Go to Email Inbox',
                        process: () async {
                          await LaunchApp.openApp(
                              androidPackageName: 'com.google.android.gm',
                              openStore: true);
                        },
                        screenWidth: screenWidth),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'If you haven’t received the link yet, please click on resend button',
                  style: kTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              LightMainButton(
                  title: 'Resend',
                  process: () {
                    resendVerificationLink();
                  },
                  screenWidth: screenWidth),
              const SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
