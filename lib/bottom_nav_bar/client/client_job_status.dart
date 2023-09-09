import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/active/client_active_jobs.dart';
import 'package:taskmate/pages/client/jobs/pending/client_pending_jobs.dart';
import 'package:taskmate/pages/freelancer/proposals/completed_jobs_pages/completed_jobs.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ClientJobStatus extends StatefulWidget {
  const ClientJobStatus({super.key});

  @override
  State<ClientJobStatus> createState() => _ClientJobStatusState();
}

class _ClientJobStatusState extends State<ClientJobStatus> {
  int itemIndex = 0;

  final List _proposalItems = const [
    ClientPendingJobs(),
    ClientActiveJobs(),
    CompletedJobs(),
  ];

  void _onToggle(int? index) {
    setState(() {
      itemIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Jobs',
            style: kHeadingTextStyle,
          ),
          elevation: 0,
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
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Column(
            children: <Widget>[
              ToggleSwitch(
                activeBgColor: const [kOceanBlueColor],
                activeFgColor: kDeepBlueColor,
                inactiveBgColor: kLightBlueColor,
                inactiveFgColor: kOceanBlueColor,
                cornerRadius: 10.0,
                radiusStyle: true,
                minWidth: screenWidth,
                minHeight: 50.0,
                initialLabelIndex: itemIndex,
                totalSwitches: 3,
                customTextStyles: const [
                  TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                ],
                labels: const ['Pending', 'Active', 'Completed'],
                onToggle: _onToggle,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    _proposalItems[itemIndex],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
