import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/job_details.dart';

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
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
            width: screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: kDeepBlueColor, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ],
            ),
          ),
          // Display data from 'jobsnew' subcollection in separate boxes
          Column(
            children: jobNewDocs.map((subDoc) {
              final subData = subDoc.data() as Map<String, dynamic>;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: kDeepBlueColor, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subData['jobTitle'] ?? '',
                      style: kJobCardTitleTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Budget LKR.${subData['budget']}',
                            style: kJobCardDescriptionTextStyle,
                          ),
                          Text(
                            '${subData['bids']} bids',
                            style: kJobCardDescriptionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      subData['jobDescription'] ?? '',
                      style: kJobCardDescriptionTextStyle,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
