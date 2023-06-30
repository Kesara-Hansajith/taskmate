import 'package:flutter/material.dart';

//imported pages
import 'package:taskmate/authentication/splash_screen.dart';

void main() {
  runApp(
    const Taskmate(),
  );
}

class Taskmate extends StatelessWidget {
  const Taskmate({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        //Add the relevant class below
        child: SplashScreen(),
      ),
    );
  }
}
