import 'package:flutter/material.dart';
import 'package:taskmate/components/bottom_sub_text.dart';
import 'package:taskmate/components/heading_button.dart';
import 'package:taskmate/components/log_in_hlink.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/email_phone_toggle_switch.dart';
import 'package:taskmate/components/auth_textfield.dart';

class CreateMyAccount1 extends StatefulWidget {
  const CreateMyAccount1({super.key});

  @override
  State<CreateMyAccount1> createState() => _CreateMyAccount1State();
}

class _CreateMyAccount1State extends State<CreateMyAccount1> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    //final double screenHeight = screenSize.height;

    bool isChecked = false;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/noise_image.png'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: Text(
                    'Create My Account',
                    style: kHeadingTextStyle,
                  ),
                ),
                const EmailPhoneToggle(),
                AuthTextField('Email', false, null),
                AuthTextField('Password', true, Icons.lock),
                AuthTextField('Confirm Password', true, Icons.lock),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    title: const Text(
                        'I have read and agree to TaskMate’s Term of Service and Privacy Policy.'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    title: const Text(
                        'We reserve the right to terminate or suspend your account at any time for violating our policies.'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    title: const Text(
                        'I agree to receive helpful emails to find rewarding works and job leads.'),
                  ),
                ),
                HeadingButton('Create My Account', screenWidth: screenWidth),
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
    );
  }
}
