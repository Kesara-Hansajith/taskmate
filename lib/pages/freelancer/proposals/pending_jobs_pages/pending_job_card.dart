import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/constants.dart';

class PendingJobCard extends StatelessWidget {
  const PendingJobCard({
    Key? key,
    required this.jobNewDoc,
  }) : super(key: key);

  final QueryDocumentSnapshot jobNewDoc;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final subData = jobNewDoc.data() as Map<String, dynamic>;
    final jobTitle = subData['jobTitle'] as String;
    final budget = int.tryParse(subData['budget'] ?? '0') ?? 0;
    final bidsCollection = jobNewDoc.reference.collection('bidsjobs');

    return Container(
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
            'Pending...',
            style: kTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              jobTitle,
              style: kJobCardTitleTextStyle,
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future: bidsCollection.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final numBids = snapshot.data?.docs.length ?? 0;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Budget LKR.${budget.toString()}',
                    style: kJobCardDescriptionTextStyle,
                  ),
                  Text(
                    'Total Bids: $numBids',
                    style: kJobCardDescriptionTextStyle,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
