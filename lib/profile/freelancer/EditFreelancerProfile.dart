import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/Dashboard.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/invitefriends.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/Dragtoadjust.dart';
import 'package:taskmate/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskmate/profile/freelancer/data_details_screen_freelancer.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/profile/freelancer/user_repository.dart';
import 'package:taskmate/profile/freelancer/uploadcoverpage.dart';
import 'package:path/path.dart';


class EditProfile extends StatefulWidget {
  final UserModel user;
  EditProfile({required this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController professionalRoleController;
  late TextEditingController hourlyRateController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();

    professionalRoleController = TextEditingController(text: widget.user.professionalrole);
    hourlyRateController = TextEditingController(text: widget.user.hourlyRate);
    bioController = TextEditingController(text: widget.user.bio);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Profile1(
        professionalRoleController: professionalRoleController,
        hourlyRateController: hourlyRateController,
        bioController: bioController,
        parentContext: context,
        user: widget.user,
      ),
    );
  }
}

class Profile1 extends StatefulWidget {
  final TextEditingController professionalRoleController;
  final TextEditingController hourlyRateController;
  final TextEditingController bioController;
  final BuildContext parentContext;
  final UserModel user;

  Profile1({
    required this.professionalRoleController,
    required this.hourlyRateController,
    required this.bioController,
    required this.parentContext,
    required this.user,
  });

  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
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
  final TextEditingController hourlyrateController = TextEditingController();
  final TextEditingController imageurl1Controller = TextEditingController();
  final TextEditingController imageurl2Controller = TextEditingController();
  final TextEditingController imageurl3Controller = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController itemdesController = TextEditingController();
  final TextEditingController professionalroleController = TextEditingController();

  UploadTask? task;
  File? file;
  String? profileImageUrl;
  String? coverpageUrl;
  bool dataSubmitted = false;
  final double coverHeight = 220;
  final double profileHeight = 134;

  void updateData() {
    if (formKey.currentState!.validate()) {
      // Validated successfully, update the data
      // Update the data using the values in the text controllers
      // You can use the values to update the user's profile, save it to a database, etc.

      setState(() {
        dataSubmitted = true; // Set the flag to indicate data has been submitted
      });
    }
  }


  Future<File?> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final String downloadUrl = await uploadcoverpage(imageFile);

      setState(() {
        coverpageUrl = downloadUrl;
      });

      return imageFile; // Return the image file here
    }

    return null; // Return null if no image is picked
  }

  Widget buildcoverImage() =>
      Stack(
        children: [
          Container(
            color: kDeepBlueColor,
            child: coverpageUrl != null
                ? Image.network(
              coverpageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: coverHeight,
            )
                : Container(
              color: kDeepBlueColor, // White background
              width: double.infinity,
              height: coverHeight,
              child: SizedBox.shrink(), // Empty child
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () async {
                final imageFile = await _pickProfileImage();
                if (imageFile != null) {
                  Navigator.pushReplacement(
                    widget.parentContext,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DataDetailsScreenFreelancer(
                              user: widget.user), // No transition animation
                    ),
                  );
                }
              },
              icon: Icon(Icons.add_photo_alternate),
              color: Colors.white,
            ),
          ),
        ],
      );

  Widget buildProfileImage() =>
      CircleAvatar(
        radius: profileHeight / 2,
        backgroundImage: AssetImage('images/noise_image.png'),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: profileHeight / 2 - 6,
              backgroundImage: NetworkImage(
                (widget.user.profilePhotoUrl ?? ''),
              ),
            ),
            Positioned(
              top: 80,
              right: 35,
              child: IconButton(
                onPressed: () {
                  //Navigate Basuru's Profile photo update
                },
                // Handle adding photo
                icon: Icon(Icons.add_photo_alternate),
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final Size screenSize = MediaQuery
        .of(context)
        .size;
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
              SizedBox(height: 120.0),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                    child: TextField(
                      controller: widget.professionalRoleController,
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 95.0, 200.0, 10.0),
                    child: TextField(
                      controller: widget.hourlyRateController,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        // label: const Center(
                        //  child: Text("Hourly Rate"),
                        // ),
                        contentPadding:
                        EdgeInsets.fromLTRB(30.0, 10.0, 40.0, 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 160.0, 10.0, 10.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: widget.bioController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          // label: Row(
                          //  children: [
                          // Center(
                          //   child: Text('Description'),
                          // ),
                          // ],
                          //  ),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(width: 10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 370.0, 10.0, 10.0),
                    child: SizedBox(
                      width: 360,
                      child: Divider(
                        color: Color(0xFF969595),
                        thickness: 1.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 400.0, 10.0, 10.0),
                    child: Text(
                      'Portfolio',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(290.0, 395.0, 10.0, 0),
                    child: Container(
                      height: 30.0,
                      width: 100.0,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: kJetBlack, width: 0.8),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const InviteFriends(),
                            ),
                          );
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
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(35.0, 440, 10.0,
                            10.0), // Adjust this value for desired alignment
                        child: GestureDetector(
                          onTap: () {
                            // Implement code to show full photo when tapped
                            // You can use a dialog or a new page to show the full photo
                            // Example: showDialog or Navigator.push
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.user.profilePhotoUrl ?? ''),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(35.0, 440, 10.0,
                            10.0), // Adjust this value for desired alignment
                        child: GestureDetector(
                          onTap: () {
                            // Implement code to show full photo when tapped
                            // You can use a dialog or a new page to show the full photo
                            // Example: showDialog or Navigator.push
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.user.profilePhotoUrl ?? ''),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(70.0, 600.0, 10.0,
                            10.0), // Adjust this value for desired alignment
                        child: Text(
                          'Project Titile',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                              fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(110.0, 600.0, 10.0,
                            10.0), // Adjust this value for desired alignment
                        child: Text(
                          'Project Titile',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 1),
              Container( // Adjust this value for desired alignment
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
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 300,
                    0), // Adjust this value for desired alignment
                child: Text(
                  'Reviews',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 20, 0.0, 10.0),
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
                            color: kAmberColor),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(55.0, 0, 50.0, 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    updateData();
                    if (formKey.currentState!.validate()) {
                      // Validated successfully, submit the form
                      final user = UserModel(
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        address: addressController.text.trim(),
                        zipcode: zipCodeController.text.trim(),
                        street: streetController.text.trim(),
                        birthday: birthdayController.text.trim(),
                        gender: genderController.text.trim(),
                        province: provinceController.text.trim(),
                        bio: bioController.text.trim(),
                        hourlyRate: hourlyrateController.text.trim(),
                        skills: skillsController.text.trim(),
                        services: servicesController.text.trim(),
                        professionalrole: professionalroleController.text.trim(),
                        sociallink: sociallinkController.text.trim(),
                        city: cityController.text.trim(),
                        phoneNo: phoneController.text.trim(),
                        profilePhotoUrl: profileImageUrl,
                      );
                      UserRepository.instance.createUser(user);

                      // Clear the text field values
                      // firstNameController.clear();
                      // lastNameController.clear();
                      // addressController.clear();
                      // zipCodeController.clear();
                      // provinceController.clear();
                      // cityController.clear();
                      // emailController.clear();
                      // phoneController.clear();
                      // bioController.clear();
                      // skillsController.clear();
                      // servicesController.clear();
                      // professionalRoleController.clear();
                      // passwordController.clear();

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Your account is successfully created.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => DataDetailsScreenFreelancer(user: user),
                                    ),
                                  );
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>  DataDetailsScreenFreelancer(user: user),
                        ),
                      );
                    }
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            DataDetailsScreenFreelancer(user: widget.user),
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
                    //Button icon and Text goes here
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        Text(
                          'Save',
                          style:
                          TextStyle(color: kBrilliantWhite, fontSize: 15.0),
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
    );
  }
}
