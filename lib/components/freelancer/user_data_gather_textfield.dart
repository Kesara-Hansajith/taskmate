import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class UserDataGatherTextField extends StatelessWidget {
  const UserDataGatherTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validatorText,
  });

  final TextEditingController controller;
  final String hintText;
  final String validatorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.0,
            color: kDarkGreyColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2.0,
            color: kDeepBlueColor,
          ),
        ),
        filled: true,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
    );
  }
}
