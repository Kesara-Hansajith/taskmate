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

  Future<int> calculateSumOfBids(String jobDocumentID) async {
    int sum = 0;

    try {
      final subCollectionQuery = await FirebaseFirestore.instance
          .collection('jobs')
          .doc(jobDocumentID)
          .collection('jobsnew')
          .doc('1694944521298') // Replace with the appropriate subdocument ID
          .collection('bidsjobs')
          .get();

      for (final doc in subCollectionQuery.docs) {
        sum += int.tryParse(doc.id) ?? 0;
      }
    } catch (e) {
      print('Error calculating sum of bids: $e');
    }

    return sum;
  }

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
          // Display data from 'jobsnew' subcollection in separate boxes
          Column(
            children: jobNewDocs.map((subDoc) {
              final subData = subDoc.data() as Map<String, dynamic>;

              // Get the reference to the bidsjobs subcollection
              final bidsCollection = subDoc.reference.collection('bidsjobs');

              return FutureBuilder<QuerySnapshot>(
                future: bidsCollection.get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final numBids = snapshot.data?.docs.length ?? 0;

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
                                '$numBids bits', // Display the number of document IDs as bits
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
                },
              );
            }).toList(),
          ),

        ],
      ),
    );
  }
}
