import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
// import 'package:taskmate/pages/client/jobs/pending/client_pending_job_details.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/active_job_details.dart';

class ClientPendingJobCard extends StatefulWidget {
  const ClientPendingJobCard({
    super.key,
    required this.documentID,
  });

  final String documentID;

  @override
  State<ClientPendingJobCard> createState() => _ClientPendingJobCardState();
}

class _ClientPendingJobCardState extends State<ClientPendingJobCard> {
  CollectionReference projects =
  FirebaseFirestore.instance.collection('client_pending_jobs');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<DocumentSnapshot>(
      future: projects.doc(widget.documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          //Overall Active Job Card flows through here
          return InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => ClientPendingJobDetails(
              //       documentID: widget.documentID,
              //     ),
              //   ),
              // );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
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
                  Text(
                    '${data['title']}',
                    style: kJobCardTitleTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price Range: LKR.${data['priceRange']}',
                          style: kJobCardDescriptionTextStyle,
                        ),
                        Text(
                          'Job Done within: ${data['dayCount']}',
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
