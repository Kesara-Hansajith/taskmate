import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';

import '../components/snackbar.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _forgetPasswordController = TextEditingController();

  @override
  void dispose() {
    _forgetPasswordController.dispose();
    super.dispose();
  }

  Future forgetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _forgetPasswordController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Reset Link was successfully sent!'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _forgetPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Enter a valid email address'),
        );
        // Handle invalid email address
      } else if (e.code == 'user-not-found') {
        _forgetPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('User not Found'),
        );
      } else if (e.code == 'too-many-requests') {
        _forgetPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Maximum attempt count reached'),
        );
      } else {
        // Handle other FirebaseAuthExceptions
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeat,
            image: AssetImage(
              'images/noise_image.png',
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  const Image(
                    image: AssetImage('images/forgot_password.jpg'),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Did you forget password?',
                        textAlign: TextAlign.center, style: kHeadingTextStyle),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 28.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: kBrilliantWhite,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        controller: _forgetPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Email';
                          }
                          return null; // Return null for valid input
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your email here',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 28.0),
                    width: screenWidth,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kDeepBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          forgetPassword();
                          // Form is valid, proceed with submission or other actions
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Send Recovery Link',
                          style: TextStyle(fontSize: 15.0),
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
