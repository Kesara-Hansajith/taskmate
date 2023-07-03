import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class LogInHLink extends StatelessWidget {
  const LogInHLink(
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
