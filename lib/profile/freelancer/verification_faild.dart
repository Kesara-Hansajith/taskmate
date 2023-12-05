import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class VerificationFaild extends StatefulWidget {
  const VerificationFaild({super.key});

  @override
  State<VerificationFaild> createState() => _VerificationFaildState();
}

class _VerificationFaildState extends State<VerificationFaild> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(

            'Sorry!\n We can\'t activate you',
            style: kSubHeadingTextStyle,
          ),
        ),
      ),
    );
  }
}
