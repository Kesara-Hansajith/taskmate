import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/job_details.dart';

class JobCard extends StatefulWidget {
  // const JobCard({
  //   super.key,

  //   required this.title,
  //   required this.username,
  //   required this.price,
  //   required this.duration,
  // });

  const JobCard(
      {super.key, required this.documentID, required this.screenWidth});

  final double screenWidth;
  // final String? title;
  // final String? username;
  // final String? price;
  // final String? duration;
  final String? documentID;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  void getTime() {}

  @override
  Widget build(BuildContext context) {
    CollectionReference projects =
        FirebaseFirestore.instance.collection('available_projects');

    return FutureBuilder<DocumentSnapshot>(
      future: projects.doc(widget.documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          //Overall Job Card flows through here
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => JobDetails(
                    documentID: widget.documentID!,
                  ),
                ),
              );
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
              width: widget.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: kDeepBlueColor, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${data['title']}', style: kJobCardTitleTextStyle),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Budget LKR.${data['budget']}',
                          style: kJobCardDescriptionTextStyle,
                        ),
                        Text(
                          '${data['bids']} bids',
                          style: kJobCardDescriptionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${data['description']}',
                    style: kJobCardDescriptionTextStyle,
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


//New Card

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import 'package:taskmate/constants.dart';
// // import 'package:taskmate/pages/client/jobs/pending/client_pending_job_details.dart';
// // import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/active_job_details.dart';
//
// class JobCard extends StatefulWidget {
//   const JobCard({
//     required this.documentID,
//     required this.data,
//   });
//
//   final String documentID;
//   final Map<String, dynamic> data;
//
//   @override
//   State<JobCard> createState() => _JobCardState();
// }
//
// class _JobCardState extends State<JobCard> {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     // Check if widget.data is not null and is of type Map<String, dynamic>
//     if (widget.data != null && widget.data is Map<String, dynamic>) {
//       final data = widget.data as Map<String, dynamic>;
//       return InkWell(
//         onTap: () {
//           // Handle onTap action if needed
//         },
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 4.0),
//           padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
//           width: screenWidth,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16.0),
//             border: Border.all(color: kDeepBlueColor, width: 1.0),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 '${data['jobTitle']}',
//                 style: kJobCardTitleTextStyle,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Price Range: LKR.${data['budget']}',
//                       style: kJobCardDescriptionTextStyle,
//                     ),
//                     Text(
//                       'Job Done within: ${data['dayCount']}',
//                       style: kJobCardDescriptionTextStyle,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       // Handle the case when data is null or not of the expected type
//       return const Center(
//         child: Text('Data not available'),
//       );
//     }
//   }
// }
