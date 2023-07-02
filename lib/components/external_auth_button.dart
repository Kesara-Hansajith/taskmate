import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class ExternalAuthButton extends StatelessWidget {
  const ExternalAuthButton(
      this.imagePath,
      this.title, {
        super.key,
      });

  final String? imagePath;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          backgroundColor: kLightBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath!,
              width: 25.0,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              title!,
              style: const TextStyle(
                  color: kDeepBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}