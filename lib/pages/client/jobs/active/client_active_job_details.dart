import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/active/client_active_job_files_section.dart';
import 'package:taskmate/pages/client/jobs/active/client_job_details_section.dart';
import 'package:taskmate/pages/client/jobs/active/client_active_job_payments_section.dart';
import 'package:taskmate/pages/client/jobs/active/client_active_job_reviews_section.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ClientActiveJobDetails extends StatefulWidget {
  // final String documentID;
  final String jobTitle; // Add this parameter
  final String jobDescription;
  final String budgetField;
  final QueryDocumentSnapshot activeJobDoc;
  final String image1Url; // URL for image1
  final String image2Url; // URL for image2
  final String image3Url; // URL for image1
  final String image4Url; // URL for image2
  final String createdAt; // Add this parameter

   ClientActiveJobDetails({
     super.key,
     required this.jobTitle, // Add this parameter
     required this.jobDescription,
     required this.budgetField,
     required this.activeJobDoc,
     required this.image1Url,
     required  this.image2Url,
     required  this.image3Url, // URL for image1
     required  this.image4Url,
     required this.createdAt, // URL for image2
     // required this.documentID,
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
        jobTitle: widget.jobTitle,
        jobDescription : widget.jobDescription,
        budgetField: widget.budgetField,
        activeJobDoc: widget.activeJobDoc,
        image1Url: widget.image1Url, // Pass the URL of image1
        image2Url: widget.image2Url, // Pass the URL of image2
        createdAt: widget.createdAt, // Pass the createdAt value
        //documentID: widget.documentID,
      ),
       ClientActiveJobFiles(
        image3Url: widget.image3Url,
        image4Url: widget.image4Url,
         activeJobDoc: widget.activeJobDoc,
      ),
       ClientActiveJobPayment(
        budgetField: widget.budgetField,
        activeJobDoc: widget.activeJobDoc,
      ),
       ClientActiveJobReview(
        activeJobDoc: widget.activeJobDoc,

      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Active Jobs',
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
