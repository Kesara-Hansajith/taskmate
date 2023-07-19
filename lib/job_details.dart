import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  DocumentReference userDocRef = FirebaseFirestore.instance
      .collection('projects')
      .doc('NMNSqWkiXMsEWXjxuLyy');

  String? title = 'Fetching User Data...';
  String? username = 'Fetching User Data...';
  String? postedOn = 'Fetching User Data...';
  String? price = 'Fetching User Data...';
  String? duration = 'Fetching User Data...';
  String? description = 'Fetching User Data...';

  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    getProject();
  }

  Future<void> getProject() async {
    try {
      DocumentSnapshot documentSnapshot = await userDocRef.get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            title = data['title'];
            username = data['username'];
            postedOn = data['posted_on'];
            price = data['price'].toString();
            duration = data['duration'];
            description = data['description'];
          });
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/noise_image.png'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
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
                  Text(
                    'Title',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('$title'),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job Offered by',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('$username'),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('$description'),
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
      ),
    );
  }
}
