import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/FreelancerDashboard/Dashboard.dart';
import 'package:taskmate/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../ClientDashboard/Dashboard.dart';

class Dragtoadjust extends StatefulWidget {
  final File? imageFile;
  const Dragtoadjust({Key? key, this.imageFile}) : super(key: key);

  @override
  State<Dragtoadjust> createState() => _DragtoadjustState();
}

class _DragtoadjustState extends State<Dragtoadjust> {

  @override
  final formKey = GlobalKey<FormState>();
  String? CoverImageUrl;
  double _coverHeight = 220.0;
  double _dragPosition = 0.0;




  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double coverHeight = 220;


    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/noise_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {

                      },
                      icon: Icon(Icons.arrow_back_ios_sharp,size: 30.0),
                      color: kDeepBlueColor,

                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Drag to Adjust',
                        style: TextStyle(
                          fontSize: 38, // Adjust the font size as needed
                          fontWeight: FontWeight.w600,
                          color: kDeepBlueColor, // Adjust the text color as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Container(
                color: Colors.indigo,
                child: widget.imageFile != null
                    ? Image.file(
                        widget.imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: coverHeight,
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: coverHeight,
                      ),
              ),
            ],
          ),
          Positioned(
            bottom: 50.0,
            left: 200.0,
            child: Container(
              height: 60.0,
              margin: const EdgeInsets.symmetric(horizontal: 35.0),
              width: 150.0,
              decoration: BoxDecoration(
                color: kOceanBlueColor.withOpacity(0.3),
                border: Border.all(color: kOceanBlueColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: GestureDetector(
                onTap: () async {
                  if (widget.imageFile != null) {
                    // Call the function to upload the image to Firebase Storage
                    String imageUrl = await uploadProfileImage1(widget.imageFile!);

                    setState(() {
                      CoverImageUrl = imageUrl;
                    });

                    // Save the cover photo URL to Firestore
                    await saveCoverPhotoToFirestore(imageUrl);

                    // Now you can perform any additional actions or navigate to another screen.
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 45.0,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: kDeepBlueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 200.0,
            child: Container(
              height: 60.0,
              margin: const EdgeInsets.symmetric(horizontal: 35.0),
              width: 150.0,
              decoration: BoxDecoration(
                color: kDeepBlueColor,
                border: Border.all(color: kOceanBlueColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: GestureDetector(
                onTap: () async {
                  if (widget.imageFile != null) {
                    // Call the function to upload the image to Firebase Storage
                    String imageUrl = await uploadProfileImage1(widget.imageFile!);

                    setState(() {
                      CoverImageUrl = imageUrl;
                    });

                    // Save the cover photo URL to Firestore
                    await saveCoverPhotoToFirestore(imageUrl);

                    // Now you can perform any additional actions or navigate to another screen.
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 50.0,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> uploadProfileImage1(File imageFile) async {
    final Reference storageRef =
    FirebaseStorage.instance.ref().child('cover_image/${imageFile.path.split('/').last}');

    final TaskSnapshot uploadTask = await storageRef.putFile(imageFile);
    final String downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> saveCoverPhotoToFirestore(String imageUrl) async {
    try {
      final CollectionReference coverPhotoCollection = FirebaseFirestore.instance.collection('cover_photos');
      await coverPhotoCollection.add({
        'url': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving cover photo to Firestore: $e');
    }
  }
}