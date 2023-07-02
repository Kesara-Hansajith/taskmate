import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';

class AuthTextField extends StatefulWidget {
  final String? title;
  bool obscure = false;
  IconData? suffIcon;

  AuthTextField(this.title, this.obscure, this.suffIcon, {super.key});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: kBrilliantWhite,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        obscureText: widget.obscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.title,
          suffixIcon: IconButton(
            icon: Icon(widget.suffIcon,color: kJetBlack,),
            //todo: Functionality for the Password Section Obsecure text availability
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
