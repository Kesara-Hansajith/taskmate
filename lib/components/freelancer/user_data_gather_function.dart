import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class UserDataGatherFunction extends StatelessWidget {
  const UserDataGatherFunction({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validatorText,
    required this.icon,
    required this.function,
  });

  final TextEditingController controller;
  final String hintText;
  final String validatorText;
  final IconData icon;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: function,
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
        suffixIcon: Icon(icon,color: kDeepBlueColor,),
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
