import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF4F7F9),
      body: Center(
        child: Image(
          image: AssetImage('images/TaskMateLogo_Dark.png'),
        ),
      ),
    );
  }
}
