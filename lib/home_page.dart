import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskmate/authentication/log_in.dart';
import 'package:taskmate/components/bottom_sub_text.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/email_phone_toggle_switch.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kDeepBlueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            onPressed: () async {
              // Google Sign Out
              final GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              print('Signed out from Google');

              // Additional code if needed
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ), // Add some spacing between the elements
                // Other widgets you want to display in the AppBar can be added here
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  'Submit Proposal',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'what is the rate you would like to bid for this job',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 70.0,
            right: 0,
            top: 60.0,
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                color: kBrilliantWhite,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Amount',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
