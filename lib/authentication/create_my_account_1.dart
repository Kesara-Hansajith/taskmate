import 'package:flutter/material.dart';
import 'package:taskmate/authentication/log_in.dart';
import 'package:taskmate/components/bottom_sub_text.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/email_phone_toggle_switch.dart';

class CreateMyAccount1 extends StatefulWidget {
  const CreateMyAccount1({super.key});

  @override
  State<CreateMyAccount1> createState() => _CreateMyAccount1State();
}

class _CreateMyAccount1State extends State<CreateMyAccount1> {
  bool condition1 = false;
  bool condition2 = false;
  bool condition3 = false;

  bool obsecureController0 = true;
  bool obsecureController1 = true;

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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    //final double screenHeight = screenSize.height;

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
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: Text(
                    'Create My Account',
                    style: kHeadingTextStyle,
                  ),
                ),
                const EmailPhoneToggle(),
                //"Email" Textfield
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 28.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: kBrilliantWhite,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
                //"Password" Textfield goes here
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 28.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: kBrilliantWhite,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    obscureText: obsecureController0,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: obsecureController0
                            ? const Icon(Icons.lock)
                            : const Icon(Icons.lock_open),
                        color: kJetBlack,
                        //todo: Functionality for the Password Section Obsecure text availability
                        onPressed: () {
                          setObsecure0();
                        },
                      ),
                    ),
                  ),
                ),
                //"Confirm Password" Textfield goes here
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 28.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: kBrilliantWhite,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    obscureText: obsecureController1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: obsecureController1
                            ? const Icon(Icons.lock)
                            : const Icon(Icons.lock_open),
                        color: kJetBlack,
                        //todo: Functionality for the Confirm Password Section Obsecure text availability
                        onPressed: () {
                          setObsecure1();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: condition1,
                      onChanged: (bool? value) {
                        setState(() {
                          condition1 = value!;
                        });
                      },
                      activeColor: kDeepBlueColor,
                    ),
                    title: const Text(
                        'I have read and agree to TaskMate’s Term of Service and Privacy Policy.'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: condition2,
                      onChanged: (bool? value) {
                        setState(() {
                          condition2 = value!;
                        });
                      },
                      activeColor: kDeepBlueColor,
                    ),
                    title: const Text(
                        'We reserve the right to terminate or suspend your account at any time for violating our policies.'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: condition3,
                      onChanged: (bool? value) {
                        setState(() {
                          condition3 = value!;
                        });
                      },
                      activeColor: kDeepBlueColor,
                    ),
                    title: const Text(
                        'I agree to receive helpful emails to find rewarding works and job leads.'),
                  ),
                ),
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
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Create My Account',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
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
    );
  }
}
