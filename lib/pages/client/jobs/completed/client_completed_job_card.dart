import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/completed/client_completed_job_details.dart';

class ClientCompletedJobCard extends StatefulWidget {
  const ClientCompletedJobCard({
    super.key,
    // required this.documentID,
  });

  // final String documentID;

  @override
  State<ClientCompletedJobCard> createState() => _ClientCompletedJobCardState();
}

class _ClientCompletedJobCardState extends State<ClientCompletedJobCard> {
  // CollectionReference projects =
  // FirebaseFirestore.instance.collection('client_active_jobs');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ClientCompletedJobDetails(),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Completed on 2023.08.27',
              style: kTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'Title',
                style: kJobCardTitleTextStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'From FreelancerName',
                  style: kJobCardDescriptionTextStyle,
                ),
                Text(
                  'Price: LKR 7500',
                  style: kJobCardDescriptionTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    //   FutureBuilder<DocumentSnapshot>(
    //   future: projects.doc(widget.documentID).get(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data =
    //       snapshot.data!.data() as Map<String, dynamic>;
    //       //Overall Active Job Card flows through here
    //       return InkWell(
    //         onTap: () {
    //           Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (context) => ClientActiveJobDetails(
    //                 documentID: widget.documentID,
    //               ),
    //             ),
    //           );
    //         },
    //         child: Container(
    //           margin: const EdgeInsets.symmetric(vertical: 4.0),
    //           padding:
    //           const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
    //           width: screenWidth,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(16.0),
    //             border: Border.all(color: kDeepBlueColor, width: 1.0),
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Text(
    //                 '${data['title']}',
    //                 style: kJobCardTitleTextStyle,
    //               ),
    //               Text(
    //                 '${data['description']}',
    //                 style: kTextStyle,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       'Price: LKR.${data['bidPrice']}',
    //                       style: kJobCardDescriptionTextStyle,
    //                     ),
    //                     const Text(
    //                       'Date goes here',
    //                       style: kJobCardDescriptionTextStyle,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     }
    //     return const Center(
    //       child: Text('Loading....'),
    //     );
    //   },
    // );
  }
}
