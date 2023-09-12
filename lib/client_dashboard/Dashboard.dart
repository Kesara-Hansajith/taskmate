import 'package:flutter/material.dart';
import 'package:taskmate/client_dashboard/Balance.dart';
import 'package:taskmate/client_dashboard/Dragtoadjust.dart';
import 'package:taskmate/client_dashboard/Help.dart';
import 'package:taskmate/client_dashboard/Transactionhistory.dart';
import 'package:taskmate/client_dashboard/invitefriends.dart';
import 'package:taskmate/client_dashboard/termsandconditions.dart';
import 'package:taskmate/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskmate/profile/client/data_details_screen_client.dart';
import 'dart:io';

import '../profile/client/user_model1.dart';

class DashboardClient extends StatefulWidget {
  final UserModel1 client; // Add this line
  final String? profileImageUrl;

  const DashboardClient({
    Key? key,
    required this.client,
    this.profileImageUrl,
  });

  @override
  State<DashboardClient> createState() => _DashboardClientState();
}

class _DashboardClientState extends State<DashboardClient> {
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
  final TextEditingController professionalroleController =
      TextEditingController();

  String? profileImageUrl;
  String? CoverImageUrl;
  final double coverHeight = 220;
  final double profileHeight = 134;

  Future<File?> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final String downloadUrl = await uploadProfileImage1(imageFile);

      setState(() {
        CoverImageUrl = downloadUrl;
      });

      return imageFile; // Return the image file here
    }

    return null; // Return null if no image is picked
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      return 'Good Morning!';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon!';
    } else if (hour >= 17 && hour < 20) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }

  Widget buildcoverImage() => Stack(
        children: [
          Container(
            color: kDeepBlueColor,
            child: widget.profileImageUrl != null
                ? Image.network(
                    widget.profileImageUrl ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: coverHeight,
                  )
                : SizedBox(
                    width: double.infinity,
                    height: coverHeight,
                  ),
          ),
          Positioned(
            bottom: 10, // Adjust the values as needed for positioning
            left: 10, // Adjust the values as needed for positioning
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundImage: const AssetImage('images/noise_image.webp'),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: profileHeight / 2 - 6,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(widget.profileImageUrl ?? ''),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            // Add the background image here
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/noise_image.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            buildcoverImage(),

            Positioned(
              top: top,
              left: (screenWidth - profileHeight) / 2,
              child: Column(
                children: [
                  buildProfileImage(),
                  SizedBox(height: 8.0),
                  Text(
                    '${widget.client.firstName} ${widget.client.lastName}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF16056B),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: screenSize.height *
                  0.4, // Adjust this value for desired alignment
              left: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => DataDetailsScreenClient(
                              client: widget.client,
                              profileImageUrl: widget.profileImageUrl),
                        ),
                      );
                    },
                    child: const Text(
                      'Profile',
                      style: TextStyle(
                        color: Color(0xFF545353),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => BalanceClient(
                              client: widget.client,
                              profileImageUrl: widget.profileImageUrl),
                        ),
                      );
                      // Handle button press
                    },
                    child: const Text(
                      'Balance',
                      style: TextStyle(
                        color: Color(0xFF545353),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => TransactionhistoryClient(
                              client: widget.client,
                              profileImageUrl: widget.profileImageUrl),
                        ),
                      );
                      // Handle button press
                    },
                    child: const Text(
                      'Transaction History',
                      style: TextStyle(
                        color: Color(0xFF545353),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: screenSize.height *
                  0.6, // Adjust this value for desired alignment
              left: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HelpClient(
                              client: widget.client,
                              profileImageUrl: widget.profileImageUrl),
                        ),
                      );
                    },
                    child: const Text(
                      'Help & support',
                      style: TextStyle(
                        color: Color(0xFF545353),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Adjust the spacing between buttons
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => InviteFriendsClient(
                              client: widget.client,
                              profileImageUrl: widget.profileImageUrl),
                        ),
                      );
                    },
                    child: const Text(
                      'Invite friends',
                      style: TextStyle(
                        color: Color(0xFF545353),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => TermsandConditionsClient(
                              client: widget.client,
                              profileImageUrl: widget.profileImageUrl),
                        ),
                      );
                      // Handle button press
                    },
                    child: const Text(
                      'Terms & conditions',
                      style: TextStyle(
                        color: Color(0xFF545353),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: screenSize.height *
                  0.08, // Adjust this value for desired alignment
              left: screenSize.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle logout
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: kAmberColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: screenSize.height *
                  0.065, // Adjust this value for desired alignment
              left: screenSize.width * 0.36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Version 1.0.0.0.1', // Replace with desired version text
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> uploadProfileImage1(File imageFile) async {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('cover_image/${imageFile.path.split('/').last}');

    final TaskSnapshot uploadTask = await storageRef.putFile(imageFile);
    final String downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }
}
