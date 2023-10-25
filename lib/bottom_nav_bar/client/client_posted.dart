import 'package:flutter/material.dart';
import 'package:taskmate/components/client/post_a_job.dart';
import 'package:taskmate/constants.dart';
// import 'package:taskmate/profile/client/user_model1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmate/pages/client/jobs/pending/client_pending_job_card.dart';

class ClientPosted extends StatefulWidget {
  const ClientPosted({
    super.key,
    // required this.client,
  });

  // final UserModel1 client; // Add this line

  @override
  State<ClientPosted> createState() => _ClientPostedState();
}

class _ClientPostedState extends State<ClientPosted> {
  final bool isJobsAvailable = true;

  @override
  Widget build(BuildContext context) {
    String? userUid = FirebaseAuth.instance.currentUser?.uid;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 60.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back, ',
                      style: kJobCardTitleTextStyle.copyWith(
                          color: kDarkGreyColor),
                    ),
                    const Text(
                      'First Name Last Name',
                      style: kSubHeadingTextStyle,
                    ),
                    PostAJob(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
