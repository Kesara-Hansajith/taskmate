import 'package:flutter/material.dart';
class UserDataGatherTitle extends StatelessWidget {
  const UserDataGatherTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13, // Set the desired font size
          color: Color(0xFF4B4646), // Set the desired font color
          fontWeight: FontWeight.bold,),),);}}