import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/active_job_details.dart';

class ActiveJobCard extends StatefulWidget {
  const ActiveJobCard({
    super.key,
    // required this.documentID,
  });

  // final String documentID;

  @override
  State<ActiveJobCard> createState() => _ActiveJobCardState();
}

class _ActiveJobCardState extends State<ActiveJobCard> {
  // CollectionReference projects =
  //     FirebaseFirestore.instance.collection('active_jobs');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ActiveJobDetails()));
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
                Text(
                  // '${data['title']}',
                  'In Progress . . . ',
                  style: kTextStyle,
                ),
                Icon(
                  Icons.arrow_circle_right,
                  color: kDeepBlueColor,
                  size: 25.0,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                // '${data['title']}',
                'Title',
                style: kJobCardTitleTextStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // 'Bid Price: LKR.${data['bidPrice']}',
                  'Bid Price: LKR. 1000',
                  style: kJobCardDescriptionTextStyle,
                ),
                Text(
                  // 'Total Bids: ${data['bidCount']}',
                  'Total Bids: 41',
                  style: kJobCardDescriptionTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//   FutureBuilder<DocumentSnapshot>(
//   future: projects.doc(widget.documentID).get(),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.done) {
//       Map<String, dynamic> data =
//           snapshot.data!.data() as Map<String, dynamic>;
//       //Overall Active Job Card flows through here
//       return InkWell(
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => ActiveJobDetails(
//                 documentID: widget.documentID,
//               ),
//             ),
//           );
//         },
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 4.0),
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
//               Text(
//                 // '${data['title']}',
//                 'Title',
//                 style: kJobCardTitleTextStyle,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       // 'Bid Price: LKR.${data['bidPrice']}',
//                       'Bid Price',
//                       style: kJobCardDescriptionTextStyle,
//                     ),
//                     Text(
//                       // 'Total Bids: ${data['bidCount']}',
//                       'Total Bids',
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
