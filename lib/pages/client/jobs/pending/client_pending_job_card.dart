import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/pending/bidded_freelancers.dart';

class ClientPendingJobCard extends StatefulWidget {
  ClientPendingJobCard({
    Key? key,
    required this.pendingjobDoc,
  }) : super(key: key);

  final QueryDocumentSnapshot pendingjobDoc;

  @override
  State<ClientPendingJobCard> createState() => _ClientPendingJobCardState();
}

class _ClientPendingJobCardState extends State<ClientPendingJobCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final subData = widget.pendingjobDoc.data() as Map<String, dynamic>;
    final jobTitle = subData['jobTitle'] as String;
    final budget = int.tryParse(subData['budget'].toString() ?? '0') ?? 0;
    final bidsCollection = widget.pendingjobDoc.reference.collection('bidsjobs');

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BiddedFreelancers(

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
          border: Border.all(color: kDeepBlueColor, width: 1.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    jobTitle,
                    style: kJobCardTitleTextStyle,
                  ),
                ),
                Text(
                  'Budget LKR.${budget.toString()}',
                  style: kJobCardDescriptionTextStyle,
                ),
                Text(
                  'Posted on: ',
                  style: kJobCardDescriptionTextStyle,
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
                          'Proposals: $numBids',
                          style: kJobCardDescriptionTextStyle.copyWith(
                              fontWeight: FontWeight.bold, color: kDeepBlueColor),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const Icon(
              Icons.navigate_next,
              size: 35.0,
            ),
          ],
        ),
      ),
    );
  }
}
