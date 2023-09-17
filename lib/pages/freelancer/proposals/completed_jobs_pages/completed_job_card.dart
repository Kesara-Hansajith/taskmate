import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/proposals/completed_jobs_pages/completed_job_details.dart';

class CompletedJobCard extends StatefulWidget {
  const CompletedJobCard({
    super.key,
    // required this.documentID,
  });

  // final String documentID;

  @override
  State<CompletedJobCard> createState() => _CompletedJobCardState();
}

class _CompletedJobCardState extends State<CompletedJobCard> {
  // CollectionReference projects =
  //     FirebaseFirestore.instance.collection('completed_jobs');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CompletedJobDetails()));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Completed on 2023.08.25',
                  style: kTextStyle,
                ),
                Icon(Icons.arrow_circle_right,color: kDeepBlueColor,size: 25.0,),
              ],
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
                  'by ClientName',
                  style: kJobCardDescriptionTextStyle,
                ),
                Text(
                  'Price: LKR 9000',
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
    //           snapshot.data!.data() as Map<String, dynamic>;
    //       //Overall Job Card flows through here
    //       return InkWell(
    //         onTap: () {
    //           Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (context) => CompletedJobDetails(
    //                 documentID: widget.documentID,
    //               ),
    //             ),
    //           );
    //         },
    //         child:
    //         Container(
    //           margin:
    //               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    //           padding:
    //               const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
    //           width: screenWidth,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(16.0),
    //             border: Border.all(color: kDeepBlueColor, width: 1.0),
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               const Text(
    //                 'Completed',
    //                 style: kTextStyle,
    //               ),
    //               Text('${data['title']}', style: kJobCardTitleTextStyle),
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       '@${data['userName']}',
    //                       style: kJobCardDescriptionTextStyle,
    //                     ),
    //                     Text(
    //                       'LKR.${data['bidPrice']}',
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
