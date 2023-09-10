import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io'; // Add this import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmate/profile/client/data_details_screen_client.dart';
import 'package:taskmate/profile/client/user_model1.dart';
import 'package:taskmate/profile/freelancer/data_details_screen_freelancer.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_4.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/constants.dart';
import 'package:path/path.dart' as path;

class EditClientProfile extends StatefulWidget {
  final UserModel1 client;
  final String? profileImageUrl;

  EditClientProfile({required this.client, this.profileImageUrl});

  @override
  _EditClientProfileState createState() => _EditClientProfileState();
}

class _EditClientProfileState extends State<EditClientProfile> {
  final TextEditingController professionalRoleController = TextEditingController();


  String? profileImageUrl;


  final double profileHeight = 134;
  final double coverHeight = 220; // Store the updated profile image URL here

  Widget buildProfileImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: profileHeight / 2,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: profileHeight / 2 - 6,
            backgroundImage: NetworkImage(profileImageUrl ?? 'YOUR_DEFAULT_IMAGE_URL_HERE'), // Replace 'YOUR_DEFAULT_IMAGE_URL_HERE' with your default image URL or set it to null for no image
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              _updateProfileImage();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black, // Customize the color as needed
              ),
              child: Icon(
                Icons.add_a_photo_outlined,
                color: Colors.white, // Customize the icon color as needed
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget buildCoverImage() {
    return Stack(
      children: [
        Container(
          color: kDeepBlueColor,
          child: widget.profileImageUrl != null
              ? Image.network(widget.profileImageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: coverHeight,
          )
              : Placeholder(),
          // You can replace Placeholder with a loading indicator
        ),

      ],
    );
  }



  @override
  void initState() {
    super.initState();
    // Initialize the text fields with the existing user data
    // Use user's bio or an empty string if it's null
    professionalRoleController.text = widget.client.professionalrole ?? ''; // Use user's role or an empty string if it's null
    profileImageUrl = widget.client.profilePhotoUrl;
  }

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/noise_image.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          // Wrap your entire content with SingleChildScrollView
          child: Form(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    buildCoverImage(),
                    Positioned(
                      top: top,
                      left: (screenWidth - profileHeight) / 2,
                      child: buildProfileImage(),
                    ),
                  ],
                ),
                SizedBox(height: 70),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '${widget.client.firstName} ${widget.client.lastName}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 10), // Add some spacing between the name and the level
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: TextField(
                    controller: professionalRoleController,
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      //label: const Center(
                      //    child: Text("Professional Roles"),
                      //   ),
                      contentPadding:
                      EdgeInsets.fromLTRB(40.0, 24.0, 40.0, 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 2.0),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Container(
                  // Adjust this value for desired alignment
                  child: Center(
                    child: SizedBox(
                      width: 360,
                      child: Divider(
                        color: Color(0xFF969595),
                        thickness: 1.2,
                      ),
                    ),
                  ),
                ),
                Column(
                    children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(05.0, 10.0, 300.0, 10.0),
                  child: Text(
                    'Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
          ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 0, 0.0, 0.0),
                  child: SizedBox(
                    width: 300, // Adjust the width as needed
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Review Part Under Construction',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: kAmberColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Display existing user details in non-editable form fields
                SizedBox(height: 50),
                Container(
                  // Adjust this value for desired alignment
                  child: Center(
                    child: SizedBox(
                      width: 360,
                      child: Divider(
                        color: Color(0xFF969595),
                        thickness: 1.2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 100),
                Container(
                  width:300,
                  child:ElevatedButton(
                    onPressed: () async {
                      // Update Firestore data with the new bio and professional role
                      await updateFirestoreData();
                      final updatedUser = UserModel1(
                        professionalrole: professionalRoleController.text,
                        profilePhotoUrl: profileImageUrl,
                        firstName: widget.client.firstName, // Keep existing first name
                        lastName: widget.client.lastName,
                        email: '',
                        password: '',
                        address: '',
                        zipcode: '',
                        birthday: '', gender: '', province: '',
                        city: '', street: '', phoneNo: '',
                        // ... other user data fields ...
                      );

                      // Navigate back to the previous screen and pass the updated user data
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => DataDetailsScreenClient(
                            client: updatedUser,
                            profileImageUrl: profileImageUrl,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDeepBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Text(
                            'Save',
                            style: TextStyle(
                              color: kBrilliantWhite,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateFirestoreData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      final String userUid = firebaseUser.uid;

      try {
        await FirebaseFirestore.instance
            .collection('Clients')
            .doc(userUid)
            .update(
          {

            'professionalRole': professionalRoleController.text, // Updated professional role
            'profilePhotoUrl': profileImageUrl,
          },
        );
      } catch (e) {
        // Handle errors, e.g., show an error message to the user
        print("Error updating profile: $e");
        // You can also show a snackbar or dialog with an error message.
      }
    }
  }

  Future<void> _updateProfileImage() async {
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String fileName = path.basename(pickedImage.path);
        Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('profile_images/$fileName');

        UploadTask uploadTask = firebaseStorageRef.putFile(File(pickedImage.path));

        await uploadTask.whenComplete(() async {
          String updatedImageUrl = await firebaseStorageRef.getDownloadURL();

          setState(() {
            profileImageUrl = updatedImageUrl;
          });
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
