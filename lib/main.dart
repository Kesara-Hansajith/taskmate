import 'package:flutter/material.dart';

//imported pages
import 'package:taskmate/authentication/splash_screen.dart';
import 'package:taskmate/authentication/log_in.dart';
import 'package:taskmate/authentication/take_action.dart';
import 'package:taskmate/authentication/sign_up.dart';

void main() {
  runApp(
    const Taskmate(),
  );
}

class Taskmate extends StatelessWidget {
  const Taskmate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      home: const SafeArea(
        //Add the relevant class below
        child: SignUp(),
      ),
    );
  }
}
