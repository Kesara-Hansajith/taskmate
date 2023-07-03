import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class SignUpHLink extends StatelessWidget {
  const SignUpHLink(
    this.title, {
    super.key,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title!,
        style: const TextStyle(
          color: kAmberColor,
        ),
      ),
    );
  }
}
