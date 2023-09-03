import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'dart:io';

import 'package:taskmate/constants.dart';
import 'package:taskmate/profile/freelancer/data_details_screen_freelancer.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/verify_identity.dart';

class ProfileFreelancerAddphoto extends StatefulWidget {
  final UserModel user;

  const ProfileFreelancerAddphoto({Key? key, required this.user})
      : super(key: key);

  @override
  _ProfileFreelancerAddphotoState createState() =>
      _ProfileFreelancerAddphotoState();
}

class _ProfileFreelancerAddphotoState extends State<ProfileFreelancerAddphoto> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
  final TextEditingController imageurl1Controller = TextEditingController();
  final TextEditingController imageurl2Controller = TextEditingController();
  final TextEditingController imageurl3Controller = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController itemdesController = TextEditingController();

  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;

  List<String> selectedServices = [];
  File? selectedImage;

  String? get existingUserId => null;

  void updateData() {
    if (formKey.currentState!.validate()) {
      setState(() {
        dataSubmitted = true;
      });
    }
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask;

      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      return '';
    }
  }

  void _chooseAPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Upload image to Firebase Storage and get the download URL

      // Refresh the UI if needed
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void _takeAPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void _submitDetails() async {
    if (selectedImage != null) {
      // Upload image to Firebase Storage and get the download URL
      final String downloadUrl = await uploadImageToFirebaseStorage(
          selectedImage!);

      // Get the current user's UID from Firebase Authentication
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? firebaseUser = _auth.currentUser;

      if (firebaseUser != null) {
        // Use the user's UID as the Firestore document ID
        final String userUid = firebaseUser.uid;

        // Create a Firestore document and save the data
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userUid)
            .set(
          {
            'firstName': widget.user.firstName,
            'lastName': widget.user.lastName,
            'address': widget.user.address,
            'zipcode': widget.user.zipcode,
            'street': widget.user.street,
            'birthday': widget.user.birthday,
            'gender': widget.user.gender,
            'province': widget.user.province,
            'city': widget.user.city,
            'phoneNo': widget.user.phoneNo,
            'hourlyRate': widget.user.hourlyRate,
            'skills': widget.user.skills,
            'bio': widget.user.bio,
            'services': widget.user.services,
            'socialLink': widget.user.sociallink,
            'email': widget.user.email,
            'password': widget.user.password,
            'professionalRole': widget.user.professionalRole,
            'profilePhotoUrl': downloadUrl,
          },
        );
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  DataDetailsScreenFreelancer(
                    user: widget.user,
                    profileImageUrl: downloadUrl,
                  ),
            ),
          );
        }
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
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/noise_image.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Add a Profile Photo',
                    style: kHeadingTextStyle,
                  ),
                ),
              ),
              Expanded(
                child: CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.transparent,
                  backgroundImage: selectedImage != null
                      ? FileImage(
                          selectedImage!) // Display selected/captured image
                      : profileImageUrl != null
                          ? NetworkImage(profileImageUrl!)
                          : const AssetImage(
                                  'images/iconamoon_profile-circle-thin.png')
                              as ImageProvider<Object>,
                ),
              ),
              DarkMainButton(
                title: 'Choose a Photo from Gallery',
                process: _chooseAPhoto,
                screenWidth: screenWidth,
              ),
              LightMainButton(
                title: 'Take a Photo',
                process: _takeAPhoto,
                screenWidth: screenWidth,
              ),
              const SizedBox(
                height: 20.0,
              ),
              DarkMainButton(
                title: 'Submit',
                process: _submitDetails,
                screenWidth: screenWidth,
              ),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
