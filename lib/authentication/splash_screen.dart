import 'package:flutter/material.dart';
import 'dart:async';

import 'package:taskmate/authentication/get_started.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String image = 'images/TaskMateLogo_Dark.webp';

  Future<void> loadImage(String imageUrl) async {
    try {
      await precacheImage(AssetImage(image), context);
    } catch (e) {
      //Ignored
    }
  }

  @override
  void initState() {
    super.initState();
    loadImage(image);

    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const GetStarted(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7F9),
        body: Center(
          child: Image(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
