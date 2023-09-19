import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/client_home_page.dart';
import 'package:taskmate/components/attachment_card.dart';

import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_textfield.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/profile/client/user_model1.dart';

class ClientPostJob extends StatefulWidget {
  const ClientPostJob({
    // required this.client,
    Key? key,
  });

  // final UserModel1 client;

  @override
  State<ClientPostJob> createState() => _ClientPostJobState();
}

class _ClientPostJobState extends State<ClientPostJob> {
  final formKey = GlobalKey<FormState>();
  List<String> _skills = [];
  String _skillsText = '';

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController dayCountController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController skillController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the text controllers to prevent memory leaks
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    dayCountController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  void selectService(String serviceName) {
    setState(() {
      _skills.add(serviceName);
      skillController.text = _skills.join(', '); // Update the text field
    });
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

      // Generate a unique job ID (e.g., using a timestamp)
      String timestamp = Timestamp.now().millisecondsSinceEpoch.toString();

      // Use the user's UID as the document ID for the main job document
      DocumentReference jobDocument = jobsCollection.doc(userUid);

      // Create or update a subcollection called "jobsnew" under the main job document
      CollectionReference jobsNewCollection = jobDocument.collection('jobsnew');

      // Add job data to Firestore within the "jobsnew" subcollection
      await jobsNewCollection.doc(timestamp).set({
        'JobID': timestamp,
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Post a Job',
            style: kHeadingTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 4,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.navigate_before,
              color: kDeepBlueColor,
            ),
          ),
          flexibleSpace: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'images/noise_image.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/noise_image.webp'),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 12.0,),
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
                  const SizedBox(height: 12.0,),
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
                  const SizedBox(height: 12.0,),
                  const UserDataGatherTitle(
                    title: 'Skills',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: skillController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Add Skills',
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
                      maxLines: 2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Service 1 and Service 2 side by side
                      GestureDetector(
                        onTap: () => selectService('Logo Design'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 26.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Adjust the padding
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: kDarkGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Logo Design',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () => selectService('Illustrator'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Adjust the padding
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: kDarkGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Illustrator',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Service 1 and Service 2 side by side
                      GestureDetector(
                        onTap: () => selectService('Photoshop'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 26.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Adjust the padding
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: kDarkGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Photoshop',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () => selectService('Print design'),
                      //   child: Container(
                      //     margin: const EdgeInsets.symmetric(horizontal: 0.0),
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 16.0,
                      //         vertical: 8.0), // Adjust the padding
                      //     decoration: BoxDecoration(
                      //       color: Colors.transparent,
                      //       border: Border.all(
                      //         color: kDarkGreyColor,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: const Text(
                      //       'Print design',
                      //       style: TextStyle(
                      //         fontSize: 11,
                      //         fontWeight: FontWeight.bold,
                      //         color: kDarkGreyColor,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 12.0,),
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
                  const SizedBox(height: 12.0,),
                  const UserDataGatherTitle(
                    title: 'Budget',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: budgetController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: 'LKR  ',
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
                  const SizedBox(height: 12.0,),
                  const UserDataGatherTitle(
                    title: 'Attachments',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AttachmentCard(
                      cardChild: Text('Tap Here'),
                    ),
                  ),
                  const SizedBox(height: 12.0,),
                  DarkMainButton(
                    title: 'Post Job Now',
                    process: () {
                      if (formKey.currentState!.validate()) {
                        String jobTitle = jobTitleController.text;
                        String jobDescription = jobDescriptionController.text;
                        int dayCount =
                            int.tryParse(dayCountController.text) ?? 0;
                        int budget = int.tryParse(budgetController.text) ?? 0;
                        addJobToFirestore(
                            jobTitle, jobDescription, dayCount, budget);
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
                                  style: kSubHeadingTextStyle.copyWith(
                                      height: 0.5),
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
                                          builder: (context) => ClientHomePage(
                                              // selectedIndex: 2,
                                              // client: widget.client,
                                              ),
                                        ),
                                      );
                                    },
                                    screenWidth: screenWidth)
                              ],
                            );
                          },
                        );
                      }
                    },
                    screenWidth: screenWidth,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
