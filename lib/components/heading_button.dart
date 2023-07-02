import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class HeadingButton extends StatelessWidget {
  const HeadingButton(
    this.title, {
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 28.0),
      width: screenWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDeepBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title!,
            style: const TextStyle(fontSize: 15.0),
          ),
        ),
      ),
    );
  }
}
