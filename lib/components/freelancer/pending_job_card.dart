import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';

class PendingJobCard extends StatefulWidget {
  const PendingJobCard({
    super.key,
    required this.screenWidth,
    this.documentID,
  });

  final double screenWidth;
  final String? documentID;

  @override
  State<PendingJobCard> createState() => _PendingJobCardState();
}

class _PendingJobCardState extends State<PendingJobCard> {
  CollectionReference projects =
      FirebaseFirestore.instance.collection('pending_jobs');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<DocumentSnapshot>(
      future: projects.doc(widget.documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          //Overall Job Card flows through here
          return InkWell(
            onTap: () {},
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: kDeepBlueColor, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('In Progress', style: kTextStyle),
                  Text('${data['title']}', style: kJobCardTitleTextStyle),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bid Price: LKR. ${data['bidAmount']}',
                          style: kJobCardDescriptionTextStyle,
                        ),
                        Text(
                          'Total Bids: ${data['totalBids']}',
                          style: kJobCardDescriptionTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: Text('Loading....'),
        );
      },
    );
  }
}
