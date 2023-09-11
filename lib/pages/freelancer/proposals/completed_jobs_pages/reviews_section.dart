import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/models/completed_job_details_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews extends StatefulWidget {
  const Reviews({
    required this.documentID,
    super.key,
  });
  final String documentID;

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  Future<List<CompletedJobDetailsData>> fetchData(String documentId) async {
    final DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('completed_jobs')
        .doc(documentId)
        .get();

    return [
      CompletedJobDetailsData(
        clientReview: docSnapshot['clientReview'] as String,
        freelancerReview: docSnapshot['freelancerReview'] as String,
        username: docSnapshot['userName'] as String,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder<List<CompletedJobDetailsData>>(
            future: fetchData(widget.documentID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No data available.');
              } else if (snapshot.hasData) {
                List<CompletedJobDetailsData> data = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          child: Text(
                            'Review from @${data[0].username}',
                            style: kJobCardTitleTextStyle.copyWith(
                                color: kJetBlack),
                          ),
                        ),
                        Text(
                          data[0].clientReview!,
                          style: kTextStyle,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Divider(
                          thickness: 1.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          child: Text(
                            'Your Review',
                            style: kJobCardTitleTextStyle.copyWith(
                                color: kJetBlack),
                          ),
                        ),
                        Text(
                          data[0].freelancerReview!,
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Text('');
              }
            },
          ),
        ],
      ),
    );
  }
}
