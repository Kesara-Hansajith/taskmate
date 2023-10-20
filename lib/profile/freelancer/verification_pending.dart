import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/profile/freelancer/verification_faild.dart';
import '../../freelancer_home_page.dart';

// ... (existing imports)

class VerificationPending extends StatefulWidget {
  final UserModel user;
  final String userUid; // Add this line


  const VerificationPending({
    required this.user,
    required this.userUid,
    Key? key,
  }) : super(key: key);

  @override
  State<VerificationPending> createState() => _VerificationPendingState();
}

class _VerificationPendingState extends State<VerificationPending> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'We are working on it',
                style: kSubHeadingTextStyle,
              ),
              DarkMainButton(
                title: 'Refresh',
                process: () async {
                  // Get the current user's document reference
                  DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(widget.userUid);

                  try {
                    // Fetch the latest data from Firestore
                    DocumentSnapshot snapshot = await userDoc.get();

                    // Check if the document exists
                    if (snapshot.exists) {
                      // Check if the 'verify' field is present
                      if ((snapshot.data() as Map<String, dynamic>).containsKey('verify')) {
                        // Get the value of the 'verify' field
                        bool? isVerified = snapshot['verify'] as bool?;

                        if (isVerified != null) {
                          // Navigate based on the value of the verify field
                          if (isVerified) {
                            // If verified, navigate to FreelancerHomePage
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => FreelancerHomePage()),
                            );
                          } else {
                            // If not verified, update Firestore, then navigate to VerificationFaild
                            await userDoc.update({'verify': false}); // Update with a boolean value

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => VerificationFaild()),
                            );
                          }
                        } else {
                          // Handle the case where 'verify' field is null
                          print("'verify' field is null");
                        }
                      } else {
                        // Handle the case where 'verify' field doesn't exist
                        print("'verify' field not found");
                      }
                    } else {
                      // Handle the case where the document doesn't exist
                      print("Document not found");
                    }
                  } catch (e) {
                    print("Error fetching document: $e");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}