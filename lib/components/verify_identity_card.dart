import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';

class VerifyIdentityCard extends StatelessWidget {
  const VerifyIdentityCard({super.key, this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kDeepBlueColor,
      ),
      child: Image.asset(imagePath!),
    );
  }
}
