import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

import 'package:taskmate/pages/client/jobs/completed/details_section.dart';
import 'package:taskmate/pages/client/jobs/completed/files_section.dart';
import 'package:taskmate/pages/client/jobs/completed/payments_section.dart';
import 'package:taskmate/pages/client/jobs/completed/reviews_section.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ClientCompletedJobDetails extends StatefulWidget {
  // final String documentID;
  const ClientCompletedJobDetails({
    super.key,
    // required this.documentID,
  });

  @override
  State<ClientCompletedJobDetails> createState() => _ClientCompletedJobDetailsState();
}

class _ClientCompletedJobDetailsState extends State<ClientCompletedJobDetails> {
  int activeJobItemIndex = 0;

  void _onToggle(int? index) {
    setState(() {
      activeJobItemIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final List activeJobItems = [
      Details(
        // documentID: widget.documentID,
      ),
      const Files(),
      const Payments(),
      const Reviews(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Completed Jobs',
            style: kHeadingTextStyle,
          ),
          elevation: 4.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.navigate_before,
              color: kDeepBlueColor,
            ),
          ),
          flexibleSpace: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'images/noise_image.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ToggleSwitch(
                  activeBgColor: const [kOceanBlueColor],
                  activeFgColor: kDeepBlueColor,
                  inactiveBgColor: kLightBlueColor,
                  inactiveFgColor: kOceanBlueColor,
                  cornerRadius: 10.0,
                  radiusStyle: true,
                  minWidth: screenWidth,
                  minHeight: 50.0,
                  initialLabelIndex: activeJobItemIndex,
                  totalSwitches: 4,
                  customTextStyles: const [
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  ],
                  animate: true,
                  curve: Curves.ease,
                  labels: const ['Details', 'Files', 'Payments', 'Reviews'],
                  onToggle: _onToggle,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    width: screenWidth,
                    child: activeJobItems[activeJobItemIndex],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
