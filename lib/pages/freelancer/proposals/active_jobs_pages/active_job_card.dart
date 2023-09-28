import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/active_job_details.dart';

class ActiveJobCard extends StatelessWidget {
  const ActiveJobCard({
    Key? key,
    required this.activeJobDoc,
  }) : super(key: key);

  final QueryDocumentSnapshot activeJobDoc;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final subData = activeJobDoc.data() as Map<String, dynamic>;
    final jobTitle = subData['jobTitle'] as String;
    final budget = subData['budget']; // Remove the parsing

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ActiveJobDetails(
                  // Pass budget to ActiveJobDetails
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: kDeepBlueColor,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'In Progress...',
              style: kTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                jobTitle,
                style: kJobCardTitleTextStyle,
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Budget LKR.${budget.toString()}',
                  style: kJobCardDescriptionTextStyle,
                ),

                // Add more widgets to display other job details.
              ],
            ),
          ],
        ),
      ),
    );
  }
}