import 'package:flutter/material.dart';
import 'package:taskmate/components/attachment_card.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/freelancer_home_page.dart';
import 'package:taskmate/models/job_details_data.dart';

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
                    builder: (context) => const FreelancerHomePage(),
                  ),
                );
              },
              screenWidth: MediaQuery.of(context).size.width,
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserDataGatherTitle(
                  title: 'LKR.${subData['budget']}.00'),
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
                     SizedBox(
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
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
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
                        vertical: 10.0,
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
                            borderSide: const BorderSide(
                                color: kDeepBlueColor),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Bid Amount',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 8.0, left: 18.0),
                                child: TextFormField(
                                  controller: _bidAmountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    hintText: 'LKR',
                                    hintStyle:
                                    const TextStyle(fontSize: 12.0),
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
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Delivered within',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 18.0),
                                child: TextFormField(
                                  controller: _deliveryTimeController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    hintText: 'Days',
                                    hintStyle:
                                    const TextStyle(fontSize: 12.0),
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
                              ),
                            ],
                          ),
                        ),
                      ],
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

                      Map<String, dynamic> dataToSave = {

                        'bidDescription': _bidDescriptionController.text,
                        'bidAmount': _bidAmountController.text,
                        'delivery': _deliveryTimeController.text,
                      };


                      // Reference to the "jobsnew" subcollection
                      CollectionReference jobsNewCollection = FirebaseFirestore.instance
                          .collection('jobs')
                          .doc('flTmsaTmbVRspfnjf7FnPccq8XK2')
                          .collection('jobsnew')
                          .doc(widget.mostjobDoc.id)
                          .collection('bidsjobs');

                      // Add the data to the "jobsnew" subcollection
                      DocumentReference newBidDocRef = await jobsNewCollection.add(dataToSave);

                      // Reference to the "bidsjobs" subcollection
                      CollectionReference bidsJobsCollection = FirebaseFirestore.instance
                          .collection('jobs') // Use your actual collection name
                          .doc('flTmsaTmbVRspfnjf7FnPccq8XK2')
                          .collection('jobsnew')
                          .doc(widget.mostjobDoc.id)
                          .collection('bidsjobs');



                      // Show a success dialog

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
        ),
      ),
    );
  }
}
