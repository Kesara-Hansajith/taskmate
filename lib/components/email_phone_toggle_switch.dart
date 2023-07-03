import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:taskmate/constants.dart';

class EmailPhoneToggle extends StatelessWidget{
  const EmailPhoneToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ToggleSwitch(
        minWidth: 140.0,
        activeBgColor: const [Color(0xFF5696FA)],
        activeFgColor: kDeepBlueColor,
        inactiveBgColor: const Color(0xFFB4D7FE),
        inactiveFgColor: kOceanBlueColor,
        initialLabelIndex: 0,
        totalSwitches: 2,
        labels: const ['Email', 'Phone Number'],
        onToggle: (index) {
        },
      ),
    );
  }
}