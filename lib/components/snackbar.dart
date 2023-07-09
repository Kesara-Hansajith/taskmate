import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String title;

  CustomSnackBar(this.title, {super.key})
      : super(
          content: Text(title),
          margin: const EdgeInsets.all(3.0),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        );
}
