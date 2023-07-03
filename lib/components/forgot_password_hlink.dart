import 'package:flutter/material.dart';

class ForgotPasswordHLink extends StatelessWidget {
  const ForgotPasswordHLink(
    this.title,
    this.color, {
    super.key,
  });

  final String? title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title!,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
