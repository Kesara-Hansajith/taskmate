import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/active_job_details.dart';

import 'completed_job_details.dart';

class CompletedJobCard extends StatelessWidget {
  const CompletedJobCard({
    Key? key,
    required this.completeJobDoc,
  }) : super(key: key);

  final QueryDocumentSnapshot completeJobDoc;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final subData = completeJobDoc.data() as Map<String, dynamic>;
    final jobTitle = subData['jobTitle'] as String;
    Timestamp? createdAtTimestamp = subData['createdAt'] as Timestamp?;
    String createdAt = '';
    final jobDescription = subData['jobDescription'] as String;
    final budgetField = subData['budget'];

    final completeJobTimeField = subData['CompleteJobTime'];
    String completeJobTimeString = '';

    if (completeJobTimeField is Timestamp) {
      DateTime completeJobDateTime = completeJobTimeField.toDate();
      completeJobTimeString = DateFormat('yyyy-MM-dd HH:mm:ss').format(completeJobDateTime);
    } else if (completeJobTimeField is String) {
      // Assuming CompleteJobTime is stored as a string
      completeJobTimeString = completeJobTimeField;
    }


    String budget = '0.0'; // Initialize with a default value

    if (budgetField is int) {
      budget = budgetField.toString(); // Convert int to string
    } else if (budgetField is double) {
      budget = budgetField.toString(); // Convert double to string
    } else if (budgetField is String) {
      double? parsedBudget = double.tryParse(budgetField);
      if (parsedBudget != null) {
        budget = parsedBudget.toString();
      }
    }
    String imageUrl1 = subData['imageUrl1'] ?? ''; // Replace 'imageUrl1' with the actual field name
    String imageUrl2 = subData['imageUrl2'] ?? ''; // Replace 'imageUrl2' with the actual field name

    if (createdAtTimestamp != null) {
      DateTime createdAtDateTime = createdAtTimestamp.toDate();
      createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAtDateTime);
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CompletedJobDetails(
               jobTitle: jobTitle, // Pass the jobTitle
               budgetField: budget, // Pass the budget
               jobDescription : jobDescription,
               completeJobDoc : completeJobDoc,
               image1Url: imageUrl1, // Pass the URL of image1
               image2Url: imageUrl2, // Pass the URL of imageUrl2
               createdAt: createdAt,
              completeJobTime: completeJobTimeString,



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
              'Completed on ${completeJobTimeString.toString()} ',
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