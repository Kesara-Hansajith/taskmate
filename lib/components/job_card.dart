import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/job_details.dart';

class JobCard extends StatelessWidget {
  final QueryDocumentSnapshot mostjobDoc;
  final double screenWidth;

  JobCard({
    Key? key,
    required this.mostjobDoc,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subData = mostjobDoc.data() as Map<String, dynamic>;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetails(
              mostjobDoc: mostjobDoc,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 9.0,
        ),
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
          children: [
            Text(
              subData['jobTitle'] ?? '',
              style: kJobCardTitleTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Budget LKR.${subData['budget']}',
                    style: kJobCardDescriptionTextStyle,
                  ),
                  const SizedBox(width: 30.0,),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('jobs') // Use your actual collection name

                        .doc('2ayy7BwXAbNtWhilcMzwgUKnmQy2')
                        .collection('jobsnew')
                        .doc(mostjobDoc.id)
                        .collection('bidsjobs')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        int numBids = snapshot.data!.docs.length;
                        return Text(
                          '$numBids Bids ',
                          style: kJobCardDescriptionTextStyle,
                        );
                      } else {
                        return Text(
                          'Loading...',
                          style: kJobCardDescriptionTextStyle,
                        );
                      }
                    },
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
      ),
    );
  }
}
