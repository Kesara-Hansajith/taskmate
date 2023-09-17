import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/models/active_job_details_data.dart';
import 'package:taskmate/components/attachment_card.dart';

class Details extends StatefulWidget {
  // final String documentID;
  const Details({
    super.key,
    // required this.documentID,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // Future<List<ActiveJobDetailsData>> fetchData(String documentId) async {
  //   final DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
  //       .collection('active_jobs')
  //       .doc(documentId)
  //       .get();
  //
  //   return [
  //     ActiveJobDetailsData(
  //       title: docSnapshot['title'] as String,
  //       bidCount: docSnapshot['bidCount'] as int,
  //       bidPrice: docSnapshot['bidPrice'] as int,
  //       description: docSnapshot['description'] as String,
  //     )
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Completed on: 2023.08.25',
                  style: kTextStyle,
                )
              ],
            ),
            Text(
              'Job Title',
              style: kJobCardTitleTextStyle.copyWith(
                color: kJetBlack,
              ),
            ),
            Text(
              'Title goes here...',
              style: kTextStyle,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Description',
              style: kJobCardTitleTextStyle.copyWith(
                color: kJetBlack,
              ),
            ),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
              style: kTextStyle,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Price',
              style: kJobCardTitleTextStyle.copyWith(
                color: kJetBlack,
              ),
            ),
            Text(
              'LKR 3000',
              style: kTextStyle,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Attachments',
              style: kJobCardTitleTextStyle.copyWith(
                color: kJetBlack,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: AttachmentCard(
                      cardChild: Text('Tap Here'),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: AttachmentCard(
                      cardChild: Text('Tap Here'),
                    ),
                  ),
                ],
              ),
            ),

            // FutureBuilder<List<ActiveJobDetailsData>>(
            //   future: fetchData(widget.documentID),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else if (!snapshot.hasData) {
            //       return const Text('No data available.');
            //     } else if (snapshot.hasData) {
            //       List<ActiveJobDetailsData> data = snapshot.data!;
            //       return Center(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             const SizedBox(height: 20.0,),
            //             const Text(
            //               'Job Title',
            //               style: kJobCardTitleTextStyle,
            //             ),
            //             Text(
            //               data[0].title,
            //               style: kTextStyle,
            //             ),
            //             const Text(
            //               'Description',
            //               style: kJobCardTitleTextStyle,
            //             ),
            //             Text(
            //               data[0].description,
            //               style: kTextStyle,
            //             ),
            //             const Text(
            //               'Price',
            //               style: kJobCardTitleTextStyle,
            //             ),
            //             Text(
            //               "LKR. " + data[0].bidPrice.toString(),
            //               style: kTextStyle,
            //             ),
            //             const Text(
            //               'Attachments',
            //               style: kJobCardTitleTextStyle,
            //             ),
            //             const Text(
            //               'No Attachments',
            //               style: kTextStyle,
            //             ),
            //           ],
            //         ),
            //       );
            //     } else {
            //       return const Text('');
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
