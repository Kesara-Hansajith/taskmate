import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/details_section.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/files_section.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/payments_section.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/reviews_section.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ActiveJobDetails extends StatefulWidget {
  final String documentID;
  const ActiveJobDetails({
    super.key,
    required this.documentID,
  });

  @override
  State<ActiveJobDetails> createState() => _ActiveJobDetailsState();
}

class _ActiveJobDetailsState extends State<ActiveJobDetails> {
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
        documentID: widget.documentID,
      ),
       const Files(),
      const Payments(),
      const Reviews(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Active Job',
            style: kHeadingTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.navigate_before,
              color: kDeepBlueColor,
            ),
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
              const SizedBox(
                height: 10.0,
              ),
              ToggleSwitch(
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
              activeJobItems[activeJobItemIndex],
            ],
          ),
        ),
      ),
    );
  }
}
