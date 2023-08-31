import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';

class ActiveJobCard extends StatefulWidget {
  const ActiveJobCard({super.key});

  @override
  State<ActiveJobCard> createState() => _ActiveJobCardState();
}

class _ActiveJobCardState extends State<ActiveJobCard> {
  CollectionReference projects =
      FirebaseFirestore.instance.collection('active_jobs');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<DocumentSnapshot>(
      future: projects.doc().get(),
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
                  Text('${data['title']}', style: kJobCardTitleTextStyle),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bid Price: ${data['bidPrice']}',
                          style: kJobCardDescriptionTextStyle,
                        ),
                        Text(
                          'Total Bids goes here',
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
        return const Text('Loading....');
      },
    );
  }
}
