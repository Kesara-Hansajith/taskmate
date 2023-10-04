import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/pending/bidded_freelancer_details.dart';

class BiddedFreelancerCard extends StatelessWidget {
  final QueryDocumentSnapshot bidDoc;
  final String jobTitle;
  final QueryDocumentSnapshot pendingjobDoc;

  const BiddedFreelancerCard({
    Key? key,
    required this.bidDoc,
    required this.jobTitle,
    required this.pendingjobDoc,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final bidData = bidDoc.data() as Map<String, dynamic>;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BiddedFreelancerDetails(
              bidDescription: bidData['bidDescription'] ?? 'bidDescription',
              bidAmount: bidData['bidAmount'] ?? 'bidAmount',
              delivery: bidData['delivery'] ?? 'delivery',
              jobTitle: jobTitle,
              pendingJobDoc: pendingjobDoc,

            ),
          ),
        );
      },
      child: Ink(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: kDeepBlueColor),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/blank_profile.webp'),
                  radius: 35.0,
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      bidData['freelancerName'] ?? 'Freelancer Name',
                      style: kJobCardTitleTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        bidData['bidDescription'] ?? 'bidDescription',
                        style: kTextStyle,
                      ),
                    ),
                    Text(
                      'LKR. ${bidData['bidAmount'] ?? 0.00}',
                      style: kUserDataGatherTitleTextStyle,
                    ),
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
