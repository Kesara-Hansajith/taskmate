import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class HeadingText extends StatelessWidget {
  const HeadingText(
    this.title, {
    super.key,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: const TextStyle(
          color: kDeepBlueColor, fontSize: 35.0, fontWeight: FontWeight.bold),
    );
  }
}
