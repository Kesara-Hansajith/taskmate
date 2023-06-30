import 'package:flutter/material.dart';

//imported pages
import 'package:taskmate/authentication/splash_screen.dart';
import 'package:taskmate/authentication/log_in.dart';

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
      home: SafeArea(
        //Add the relevant class below
        child: Login(),
      ),
    );
  }
}
