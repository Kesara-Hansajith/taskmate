import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskmate/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import '../ClientDashboard/invitefriends.dart';

class Profile extends StatelessWidget {
  final usertalentController = TextEditingController();
  final userhourlyrateController = TextEditingController();

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: Profile1(
          usertalentController: usertalentController,
          userhourlyrateController: userhourlyrateController,
        ),
      );
}

class Profile1 extends StatefulWidget {
  final TextEditingController usertalentController;
  final TextEditingController userhourlyrateController;

  Profile1({
    required this.usertalentController,
    required this.userhourlyrateController,
  });

  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  UploadTask? task;
  File? file;
  String? CoverImageUrl;
  final double coverHeight = 220;
  final double profileHeight = 134;

  Widget buildcoverImage() => Stack(
        children: [
          Container(
            child: Image.network(
              'https://marketplace.canva.com/EAEmBit3KfU/1/0/1600w/canva-black-flatlay-photo-motivational-finance-quote-facebook-cover-myVl9DXwcjQ.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: coverHeight,
            ),
          ),
          //Container(
          //  color: kDeepBlueColor,
          // child: CoverImageUrl != null
          //   ? Image.network(
          //     CoverImageUrl!,
          //     fit: BoxFit.cover,
          //    width: double.infinity,
          //   height: coverHeight,
          //   )
          //  : SizedBox(
          //      width: double.infinity,
          //      height: coverHeight,
          //    ),
          //  ),
        ],
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundImage: AssetImage('images/noise_image.png'),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: profileHeight / 2 - 6,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/taskmate-8ab5f.appspot.com/o/profile_images%2Fpexels-imad-clicks-14897846.jpg?alt=media&token=dc60ac42-44e0-4081-bfa3-c8924a27737e",
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Dashboard.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  buildcoverImage(),
                  Positioned(
                    top: top,
                    left: (screenWidth - profileHeight) / 2,
                    child: buildProfileImage(),
                  ),
                ],
              ),
              SizedBox(height: 80.0),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                    child: TextField(
                      controller: widget.usertalentController,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        label: const Center(
                          child: Text("Professional Roles"),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(
                            40.0, 24.0, 40.0, 16.0), // Adjusted contentPadding
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 85.0, 200.0, 10.0),
                    child: TextField(
                      controller: widget.usertalentController,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        label: const Center(
                          child: Text("Hourly Rate"),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(
                            30.0, 10.0, 40.0, 16.0), // Adjusted contentPadding
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 141.0, 10.0, 10.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        //controller: widget.usercommentsController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          label: Center(
                            child: Row(
                              children: [
                                Center(
                                  child: Text('Description'),
                                ),
                              ],
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(150.0, 10.0, 40.0,
                              16.0), // Adjusted contentPadding
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 370.0, 10.0,
                        10.0), // Adjust this value for desired alignment
                    child: SizedBox(
                      width: 360,
                      child: Divider(
                        color: Color(0xFF969595),
                        thickness: 1.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 395.0, 10.0,
                        10.0), // Adjust this value for desired alignment
                    child: Text(
                      'Portfolio',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(290.0, 385.0, 10.0,0), // Adjust this value for desired alignment
                    child: Container(
                      height: 30.0,
                      width: 100.0,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: kJetBlack,width:0.8),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Handle button press
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              'Manage',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal,
                                color: kJetBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future uploadFile() async {
    Map<String, String> dataToSave = {
      'bid': widget.usertalentController.text,
      'comments': widget.userhourlyrateController.text,
    };
  }
}
