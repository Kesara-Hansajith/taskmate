import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class NavigateBefore extends StatelessWidget {
  const NavigateBefore({
    required this.size,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.navigate_before,
        size: size,
        color: kDeepBlueColor,
      ),
    );
  }
}
