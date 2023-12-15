import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/components/attachment_card.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/freelancer_home_page.dart';

class JobDetails extends StatefulWidget {
  final QueryDocumentSnapshot mostjobDoc;

  const JobDetails({
    Key? key,
    required this.mostjobDoc,
  }) : super(key: key);

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _bidDescriptionController =
      TextEditingController();
  final TextEditingController _bidAmountController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();

  void congratulateOnPlaceBid() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return MaintenancePage(
          [
            Transform.scale(
              scale: 1.3,
              child: const Image(
                image: AssetImage(
                  'images/success.webp',
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Congratulations!',
                style: kSubHeadingTextStyle.copyWith(
                  fontSize: 30.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'You’ve successfully placed a bid.',
                style: kTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DarkMainButton(
                title: 'Try Another Project',
                process: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FreelancerHomePage(),
                    ),
                  );
                },
                screenWidth: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // Extract job details from the document snapshot
    final subData = widget.mostjobDoc.data() as Map<String, dynamic>;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            subData['jobTitle'],
            style: kSubHeadingTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.navigate_before,
              color: kDeepBlueColor,
              size: 40.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Text(
                  'Budget',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              UserDataGatherTitle(title: 'LKR.${subData['budget']}.00'),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                child: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  subData['jobDescription'] ?? '',
                  style: kTextStyle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                child: Text(
                  'Attachments',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AttachmentCard(
                        cardChild: Image.network(
                          subData['image1Url'] ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: AttachmentCard(
                        cardChild: Image.network(
                          subData['image2Url'] ?? '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  width: screenWidth / 1.1,
                  child: const Divider(
                    color: kDarkGreyColor,
                    thickness: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                child: Text(
                  'Place a Bid on this project',
                  style: kSubHeadingTextStyle.copyWith(
                    fontSize: 18.0,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text(
                  'Describe your Bid',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: TextFormField(
                        maxLines: 5,
                        controller: _bidDescriptionController,
                        decoration: InputDecoration(
                          hintText: 'Add a clear overview about your bid',
                          hintStyle: const TextStyle(fontSize: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: kDeepBlueColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: kDeepBlueColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field cannot be empty.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Bid Amount',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                TextFormField(
                                  controller: _bidAmountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    hintText: 'LKR',
                                    hintStyle: const TextStyle(fontSize: 12.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: kDeepBlueColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: kDeepBlueColor, width: 2.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field cannot be empty.';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Delivered within',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                TextFormField(
                                  controller: _deliveryTimeController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    hintText: 'Days',
                                    hintStyle: const TextStyle(fontSize: 12.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: kDeepBlueColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: kDeepBlueColor, width: 2.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field cannot be empty.';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                margin: const EdgeInsets.symmetric(
                    horizontal: 28.0, vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Get the current user
                      User? currentUser = FirebaseAuth.instance.currentUser;


                      if (currentUser != null) {
                        String userUID = currentUser.uid;

                        // Reference to the "bidsjobs" subcollection
                        CollectionReference bidsJobsCollection = FirebaseFirestore
                            .instance
                            .collection('jobs') // Use your actual collection name
                            .doc('pDn1qSUVNLZLiAY9oTqFuV7dMzi2')
                            .collection('jobsnew')
                            .doc(widget.mostjobDoc.id)
                            .collection('bidsjobs');

                        // Use the user's UID as the document ID
                        DocumentReference newBidDocRef = bidsJobsCollection.doc(userUID);

                        // Data to be saved, including userUID
                        Map<String, dynamic> dataToSave = {
                          'bidDescription': _bidDescriptionController.text,
                          'bidAmount': _bidAmountController.text,
                          'delivery': _deliveryTimeController.text,
                          'UserUID': userUID,
                        };

                        // Set the data to the document in the "bidsjobs" subcollection
                        await newBidDocRef.set(dataToSave);

                        // Show a success dialog
                        congratulateOnPlaceBid();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 6.0,
                    backgroundColor: kAmberColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Place Bid',
                      style: kMainButtonTextStyle,
                    ),
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
