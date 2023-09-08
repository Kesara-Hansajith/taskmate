import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/portfolio_item_box.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_4.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_addphoto.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/profile/freelancer/user_repository.dart';
import '../../constants.dart';

class ProfileFreelancer3 extends StatefulWidget {
  final UserModel user;
  const ProfileFreelancer3({super.key, required this.user});

  @override
  _ProfileFreelancer3State createState() => _ProfileFreelancer3State();
}

class _ProfileFreelancer3State extends State<ProfileFreelancer3> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController sociallinkController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController servicesController = TextEditingController();
  final TextEditingController professionalRoleController = TextEditingController();
  final TextEditingController hourlyrateController = TextEditingController();
  final TextEditingController levelController = TextEditingController();


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedImageUrl1;
  String? selectedImageUrl2;
  String? selectedImageUrl3;
  String? selectedFilePath;
  String? selectedSkills;
  bool dataSubmitted = false;

  bool isTapped1 = false;
  bool isTapped2 = false;
  bool isTapped3 = false;
  bool isTapped4 = false;


  Future<String> uploadFile(File file, String filename, String fileType) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("User not authenticated.");
    }
    try {
      Reference storageRef =
          _storage.ref().child('uploads/${user.uid}/$filename');
      TaskSnapshot taskSnapshot = await storageRef.putFile(file);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return '';
    }
  }

  void updateData() {
    if (formKey.currentState!.validate()) {
      setState(() {
        dataSubmitted = true;
      });
    }
  }

  void _routeToNextPage() async {
    if (formKey.currentState!.validate()) {
      // Validated successfully, update the user data and navigate to the next page
      UserModel updatedUser = UserModel(
        firstName: widget.user.firstName,
        lastName: widget.user.lastName,
        address: widget.user.address,
        zipcode: widget.user.zipcode,
        street: widget.user.street,
        birthday: widget.user.birthday,
        gender: widget.user.gender,
        province: widget.user.province,
        city: widget.user.city,
        phoneNo: widget.user.phoneNo,
        hourlyRate: widget.user.hourlyRate,
        bio: widget.user.bio,
        skills: widget.user.skills,
        services: widget.user.services,
        email: widget.user.email,
        password: widget.user.password,
        professionalRole: widget.user.professionalRole,
        sociallink: sociallinkController.text,

      );
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? firebaseUser = _auth.currentUser;

      if (firebaseUser != null) {
        final String userUid = firebaseUser.uid;

        // Use the user's UID as the Firestore document ID
        await UserRepository.instance.createUser(updatedUser, userUid);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileFreelancerAddphoto(user: updatedUser),
          ),
        );
      } else {
        // Handle the case where the user is not authenticated
        // You may want to display an error message or redirect the user to the login page
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Set Up Your',
                          style: kHeadingTextStyle,
                        ),
                        Text(
                          'Freelancer Profile',
                          style: const TextStyle(
                            fontSize: 25,
                            color: kDeepBlueColor,
                            fontWeight: FontWeight.bold,
                          ).copyWith(height: 1.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const UserDataGatherTitle(title: 'Add portfolio link'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: sociallinkController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Ex: https://www.linkedin.com/in/desmond/',
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
                          return 'Please enter URL ';
                        }
                        final urlPattern = RegExp(
                          r"^(https?://)?([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(/\S*)?$",
                          caseSensitive: false,
                          multiLine: false,
                        );
                        if (!urlPattern.hasMatch(value)) {
                          return 'Please enter a valid URL';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      UserDataGatherTitle(title: 'Add Portfolio Items'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0), // Add horizontal padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF4B4646)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isTapped1 ? Color(0xFF5696FA) : Colors.transparent, // Set the color based on _isTapped
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                    );
                                    // Set the tapped state to true when tapped
                                    setState(() {
                                      isTapped1 = true;
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      isTapped1 ? 'Items Added' : '+ Add',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF4B4646),
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                            ),
                            SizedBox(width: 16), // Adjust the spacing between the boxes
                            Expanded(
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF4B4646)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isTapped2 ? Color(0xFF5696FA) : Colors.transparent,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                    );
                                    setState(() {
                                      isTapped2 = true;
                                    });
                                  },
                                  // Add the contents of the second box here
                                  child: Center(
                                    child: Text(
                                      isTapped2 ? 'Items Added' : '+ Add',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF4B4646),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF4B4646)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isTapped3 ? Color(0xFF5696FA) : Colors.transparent,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                    );
                                    setState(() {
                                      isTapped3 = true;
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      isTapped3 ? 'Items Added' : '+ Add',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF4B4646),
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                            ),
                            SizedBox(width: 16), // Adjust the spacing between the boxes
                            Expanded(
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF4B4646)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isTapped4 ? Color(0xFF5696FA) : Colors.transparent,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                    );
                                    setState(() {
                                      isTapped4 = true;
                                    });
                                  },
                                  // Add the contents of the second box here
                                  child: Center(
                                    child: Text(
                                      isTapped4 ? 'Items Added' : '+ Add',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF4B4646),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 220.0,
                        ),

                      ],
                    ),
                  ),
                  DarkMainButton(
                      title: 'Save & Next',
                      process: () {
                        _routeToNextPage();
                      },
                      screenWidth: screenWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
