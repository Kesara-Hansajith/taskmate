import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/proposals/completed_jobs_pages/details_section.dart';
import 'package:taskmate/pages/freelancer/proposals/completed_jobs_pages/files_section.dart';
import 'package:taskmate/pages/freelancer/proposals/completed_jobs_pages/payments_section.dart';
import 'package:taskmate/pages/freelancer/proposals/completed_jobs_pages/reviews_section.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CompletedJobDetails extends StatefulWidget {
  final String documentID;
  const CompletedJobDetails({
    super.key,
    required this.documentID,
  });

  @override
  State<CompletedJobDetails> createState() => _CompletedJobDetailsState();
}

class _CompletedJobDetailsState extends State<CompletedJobDetails> {
  int completedJobItemIndex = 0;

  void _onToggle(int? index) {
    setState(() {
      completedJobItemIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final List completedJobItems = [
      Details(
        documentID: widget.documentID,
      ),
      const Files(),
      const Payments(),
      Reviews(
        documentID: widget.documentID,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Completed Job',
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
                initialLabelIndex: completedJobItemIndex,
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
              completedJobItems[completedJobItemIndex],
            ],
          ),
        ),
      ),
    );
  }
}
