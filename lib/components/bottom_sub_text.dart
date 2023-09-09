import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class BottomSubText extends StatelessWidget {
  const BottomSubText(
    this.title, {
    super.key,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: const TextStyle(color: kDarkGreyColor, fontSize: 14.0),
    );
  }
}
