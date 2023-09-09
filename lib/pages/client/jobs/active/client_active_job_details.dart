import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/active/client_active_job_files_section.dart';
import 'package:taskmate/pages/client/jobs/active/client_job_details_section.dart';
import 'package:taskmate/pages/client/jobs/active/client_active_job_payments_section.dart';
import 'package:taskmate/pages/client/jobs/active/client_active_job_reviews_section.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ClientActiveJobDetails extends StatefulWidget {
  final String documentID;
  const ClientActiveJobDetails({
    super.key,
    required this.documentID,
  });

  @override
  State<ClientActiveJobDetails> createState() => _ClientActiveJobDetailsState();
}

class _ClientActiveJobDetailsState extends State<ClientActiveJobDetails> {
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
      ClientJobDetails(
        documentID: widget.documentID,
      ),
      const ClientActiveJobFiles(),
      const ClientActiveJobPayment(),
      const ClientActiveJobReview(),
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
        body: SingleChildScrollView(
          child: Container(
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
      ),
    );
  }
}
