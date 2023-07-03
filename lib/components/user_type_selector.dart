import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class UserTypeSelector extends StatelessWidget {
  const UserTypeSelector(this.title,{
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
      width: screenWidth,
      decoration: BoxDecoration(
        color: kLowOpacityLightBlueColor,
        border: Border.all(color: kOceanBlueColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
  title!,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF071689),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.symmetric(
              vertical: 32.0,
            ),
            width: screenWidth / 4,
            decoration: BoxDecoration(
              color: kLightBlueColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Color(0xFF071689),
            ),
          ),
        ],
      ),
    );
  }
}