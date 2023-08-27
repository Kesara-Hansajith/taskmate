import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/authentication/log_in.dart';
import 'package:taskmate/authentication/verify_email.dart';
import 'package:taskmate/components/bottom_sub_text.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmate/components/snackbar.dart';

class CreateMyAccount1 extends StatefulWidget {
  const CreateMyAccount1({super.key});

  @override
  State<CreateMyAccount1> createState() => _CreateMyAccount1State();
}

class _CreateMyAccount1State extends State<CreateMyAccount1> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked1 = false;
  bool isChecked2 = false;

  bool obsecureController0 = true;
  bool obsecureController1 = true;
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void createMyAccount() async {
    final String enteredEmail = email.text.trim();
    final String enteredPassword = password.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();
    try {
      if (enteredPassword == confirmPassword) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        sendVerificationLink(email.text);

        Fluttertoast.showToast(
          msg: "Account was successfully created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 24.0,

          // Account creation successful
        );
      } else if (enteredPassword != confirmPassword) {
        // Show a snackbar if passwords don't match
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Password does not match'),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // The password provided is too weak
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Weak password'),
        );
      } else if (e.code == 'email-already-in-use') {
        // The account already exists for that email
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Email already in use'),
        );
      }
    }
  }

  bool isCreateAccountButtonActive() {
    if (isChecked1 == true && isChecked2 == true) {
      return true;
    } else {
      return false;
    }
  }

  void setObsecure0() {
    setState(() {
      obsecureController0 = !obsecureController0;
    });
  }

  void setObsecure1() {
    setState(() {
      obsecureController1 = !obsecureController1;
    });
  }

  void _navigateToVerifyEmail() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const VerifyEmail(),
      ),
    );
  }

  Future<void> sendVerificationLink(String email) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        _navigateToVerifyEmail();
      }
    } catch (e) {
      //Ignored catch block
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/noise_image.webp'),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                      child: Text(
                        'Create My Account',
                        style: kHeadingTextStyle,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //"Email" Textfield goes here
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 28.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: kBrilliantWhite,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field can\'t be empty';
                                } else if (!value.contains('@')) {
                                  password.clear();
                                  confirmPasswordController.clear();
                                  return 'Please enter a valid Email Address';
                                }
                                return null; // Return null for valid input
                              },
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          //"Password" Textfield goes here
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 28.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: kBrilliantWhite,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field can\'t be empty';
                                }
                                return null; // Return null for valid input
                              },
                              obscureText: obsecureController0,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  icon: obsecureController0
                                      ? const Icon(Icons.lock)
                                      : const Icon(Icons.lock_open),
                                  color: kJetBlack,
                                  onPressed: () {
                                    setObsecure0();
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          //"Confirm Password" Textfield goes here
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 28.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: kBrilliantWhite,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field can\'t be empty';
                                }
                                return null; // Return null for valid input
                              },
                              obscureText: obsecureController1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                                suffixIcon: IconButton(
                                  icon: obsecureController1
                                      ? const Icon(Icons.lock)
                                      : const Icon(Icons.lock_open),
                                  color: kJetBlack,
                                  onPressed: () {
                                    setObsecure1();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ListTile(
                        leading: Checkbox(
                          value: isChecked1,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked1 = value!;
                            });
                          },
                          activeColor: kDeepBlueColor,
                        ),
                        title: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'I have read and agree to TaskMate’s',
                                style: kTextStyle.copyWith(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: ' Term of Service ',
                                style: kTextStyle.copyWith(
                                  color: kDeepBlueColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: 'and ',
                                style: kTextStyle.copyWith(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: kTextStyle.copyWith(
                                  color: kDeepBlueColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ListTile(
                        leading: Checkbox(
                          value: isChecked2,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked2 = value!;
                            });
                          },
                          activeColor: kDeepBlueColor,
                        ),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'We reserve the right to terminate or suspend your account at any time for violating our policies.',
                                style: kTextStyle.copyWith(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    DarkMainButton(
                        title: 'Create My Account',
                        process: () {
                          if (_formKey.currentState!.validate()) {
                            // Form is valid, proceed with submission or other actions
                            if (isCreateAccountButtonActive()) {
                              createMyAccount();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar(
                                    'Please agree to Terms & Conditions'),
                              );
                            }
                          }
                        },
                        screenWidth: screenWidth),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const BottomSubText('Already registered?'),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                          },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
