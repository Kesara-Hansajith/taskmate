import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/client_home_page.dart';

import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_textfield.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/profile/client/user_model1.dart';

class ClientPostJob extends StatefulWidget {
  const ClientPostJob({
    required this.client,
    Key? key,
  });

  final UserModel1 client;

  @override
  State<ClientPostJob> createState() => _ClientPostJobState();
}

class _ClientPostJobState extends State<ClientPostJob> {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController dayCountController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the text controllers to prevent memory leaks
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    dayCountController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  Future<void> addJobToFirestore(
    String jobTitle,
    String jobDescription,
    int dayCount,
    int budget,
  ) async {
    try {
      // Get the current user's UID from FirebaseAuth
      User? user = FirebaseAuth.instance.currentUser;
      String? userUid = user?.uid;

      if (userUid == null) {
        // Handle the case where the user is not authenticated
        return;
      }

      // Get a reference to the Firestore collection
      CollectionReference jobsCollection =
          FirebaseFirestore.instance.collection('jobs');

      // Generate a unique job ID
      String jobId = jobsCollection.doc().id;

      // Use the user's UID as the document ID
      DocumentReference jobDocument = jobsCollection.doc(userUid);

      // Add job data to Firestore with the unique job ID
      await jobDocument.set({
        'jobId': jobId, // Store the unique job ID as a field
        'jobTitle': jobTitle,
        'jobDescription': jobDescription,
        'dayCount': dayCount,
        'budget': budget,
        'status': 'active', // Set the status to "active"
        // You can add more fields as needed
      });
    } catch (e) {
      // Handle any errors that occur
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post a Job',
          style: kHeadingTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.navigate_before,
            color: kDeepBlueColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const UserDataGatherTitle(
                title: 'Job Title',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: UserDataGatherTextField(
                  controller: jobTitleController,
                  hintText: 'Ex: Need a Logo designer',
                  validatorText: 'Field can\'t be empty',
                ),
              ),
              const UserDataGatherTitle(
                title: 'Describe about the project',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextFormField(
                  controller: jobDescriptionController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: 'Add job description here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: kDarkGreyColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2.0,
                        color: kDeepBlueColor,
                      ),
                    ),
                    filled: true,
                  ),
                  maxLines: 6,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field can\'t be empty';
                    }
                    return null;
                  },
                ),
              ),
              const UserDataGatherTitle(
                title: 'Job done within',
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth / 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: dayCountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: '1-7 Days',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1.0,
                              color: kDarkGreyColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 2.0,
                              color: kDeepBlueColor,
                            ),
                          ),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Text('Days'),
                ],
              ),
              const UserDataGatherTitle(
                title: 'Budget',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: budgetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: 'LKR',
                    prefixStyle: const TextStyle(
                      color: Colors.red,
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: '1000-4500',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: kDarkGreyColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2.0,
                        color: kDeepBlueColor,
                      ),
                    ),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field can\'t be empty';
                    }
                    return null;
                  },
                ),
              ),
              DarkMainButton(
                title: 'Post Job Now',
                process: () {
                  String jobTitle = jobTitleController.text;
                  String jobDescription = jobDescriptionController.text;
                  int dayCount = int.tryParse(dayCountController.text) ?? 0;
                  int budget = int.tryParse(budgetController.text) ?? 0;

                  addJobToFirestore(jobTitle, jobDescription, dayCount, budget);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return MaintenancePage(
                        [
                          const Image(
                            image: AssetImage('images/tick.webp'),
                          ),
                          Text(
                            'Posted!',
                            style: kSubHeadingTextStyle.copyWith(height: 0.5),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Now keep in touch with your job for bids.',
                              style: kTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          DarkMainButton(
                              title: 'Visit Job Status',
                              process: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ClientHomePage(selectedIndex: 2,
                                      client: widget.client,
                                    ),
                                  ),
                                );
                              },
                              screenWidth: screenWidth)
                        ],
                      );
                    },
                  );
                },
                screenWidth: screenWidth,
              )
            ],
          ),
        ),
      ),
    );
  }
}
