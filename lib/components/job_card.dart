import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/job_details.dart';

import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/job_details.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    Key? key,
    required this.documentID,
    required this.screenWidth,
    required this.jobData,
    required this.jobNewDocs,
  }) : super(key: key);

  final double screenWidth;
  final String? documentID;
  final Map<String, dynamic> jobData;
  final List<QueryDocumentSnapshot> jobNewDocs;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => JobDetails(
              documentID: documentID!,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: kDeepBlueColor, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${jobData['jobTitle']}', style: kJobCardTitleTextStyle),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Budget LKR.${jobData['budget']}',
                    style: kJobCardDescriptionTextStyle,
                  ),
                  Text(
                    '${jobData['bids']} bids',
                    style: kJobCardDescriptionTextStyle,
                  ),
                ],
              ),
            ),
            Text(
              '${jobData['jobDescription']}',
              style: kJobCardDescriptionTextStyle,
            ),
            // Display data from 'jobsnew' subcollection in separate boxes
            Column(
              children: jobNewDocs.map((subDoc) {
                final subData = subDoc.data() as Map<String, dynamic>;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      subData['jobTitle'] ?? '',
                      style: kJobCardTitleTextStyle, // Apply the style here
                    ),
                    subtitle: Text(subData['jobDescription'] ?? ''),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
