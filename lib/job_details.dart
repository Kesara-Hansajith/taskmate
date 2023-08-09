import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobDetails extends StatefulWidget {
  final String? documentID;

  const JobDetails({super.key, required this.documentID});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('available_projects')
        .doc(widget.documentID);

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: userDocRef.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              //Overall Job Card flows through here
              return Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/noise_image.png'),
                    repeat: ImageRepeat.repeat,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Job Details',
                        style: kHeadingTextStyle,
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Title',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${data['title']}'),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Job Offered by',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${data['username']}'),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${data['description']}'),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      width: screenWidth,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kDeepBlueColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text('Apply Now!'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text('Loading....');
          }),
    );
  }
}
