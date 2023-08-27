import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class UserDataGatherTitle extends StatelessWidget {
  const UserDataGatherTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(
          title,
          style: kUserDataGatherTitleTextStyle
      ),
    );
  }
}