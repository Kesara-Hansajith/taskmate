import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/maintenance_page.dart';

import 'package:taskmate/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/home_page.dart';
import 'package:taskmate/models/job_details_data.dart';

class JobDetails extends StatefulWidget {
  final String documentID;
  const JobDetails({super.key, required this.documentID});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  // final _describeBidController = TextEditingController();

  String description = '';

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
            const Image(
              image: AssetImage('images/success.webp'),
            ),
            const Text(
              'Congratulations!',
              style: kSubHeadingTextStyle,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'You’ve successfully placed a bid.',
                style: kTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            DarkMainButton(
                title: 'Try Another Project',
                process: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                screenWidth: MediaQuery.of(context).size.width),
          ],
        );
      },
    );
  }

  Stream<JobDetailsData> fetchDocumentData(String documentId) {
    return FirebaseFirestore.instance
        .collection('available_projects')
        .doc(documentId)
        .snapshots()
        .map((snapshot) {
      return JobDetailsData(
        title: snapshot['title'],
        budget: snapshot['budget'],
        description: snapshot['description'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Job Details',
            style: kHeadingTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: kDeepBlueColor,
            ),
          ),
        ),
        body: StreamBuilder<JobDetailsData>(
          stream: fetchDocumentData(widget.documentID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              ); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              JobDetailsData data = snapshot.data!;
              return Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/noise_image.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          data.title,
                          textAlign: TextAlign.center,
                          style: kJobCardTitleTextStyle,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'LKR. ${data.budget}',
                          style: kJobCardDescriptionTextStyle,
                        ),
                        const Text('Remaining time goes here'),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Description',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            data.description,
                            style: kJobCardDescriptionTextStyle,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Attachments',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Divider(
                            thickness: 3.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Place a Bid on this Project',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Divider(
                            thickness: 3.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Describe your Bid',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  maxLines: 5,
                                  controller: _bidDescriptionController,
                                  maxLength: 500,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Add an clear overview about your bid',
                                    hintStyle: const TextStyle(fontSize: 12.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // Customize border radius
                                      borderSide: const BorderSide(
                                          color:
                                              kDeepBlueColor), // Customize border color
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field cannot be empty.';
                                    } else if (value.length < 500) {
                                      return 'Minimum 500 characters required.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Bid Amount',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextFormField(
                                            controller: _bidAmountController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6.0),
                                              hintText: 'LKR',
                                              hintStyle: const TextStyle(
                                                  fontSize: 12.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                // Customize border radius
                                                borderSide: const BorderSide(
                                                    color:
                                                        kDeepBlueColor), // Customize border color
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Text(
                                            'Delivered within',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextFormField(
                                            controller: _deliveryTimeController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6.0),
                                              hintText: 'Days',
                                              hintStyle: const TextStyle(
                                                  fontSize: 12.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                // Customize border radius
                                                borderSide: const BorderSide(
                                                    color:
                                                        kDeepBlueColor), // Customize border color
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            congratulateOnPlaceBid();
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
              );
            } else {
              return const Text('Document not found');
            }
          },
        ),
      ),
    );
  }
}
