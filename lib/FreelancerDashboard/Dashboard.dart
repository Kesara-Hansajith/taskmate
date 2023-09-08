import 'package:flutter/material.dart';
import 'package:taskmate/ClientDashboard/Profile.dart';
import 'package:taskmate/FreelancerDashboard/Balance.dart';
import 'package:taskmate/FreelancerDashboard/invitefriends.dart';
import 'package:taskmate/FreelancerDashboard/termsandconditions.dart';
import 'package:taskmate/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskmate/profile/freelancer/data_details_screen_freelancer.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/profile/freelancer/user_repository.dart';
import 'dart:io';
import '../ClientDashboard/Dragtoadjust.dart';
import '../ClientDashboard/Help.dart';
import '../ClientDashboard/Transactionhistory.dart';
import '../ClientDashboard/invitefriends.dart';
import '../ClientDashboard/termsandconditions.dart';
import 'Help.dart';
import 'Transactionhistory.dart';

class DashboardFreelance extends StatefulWidget {
  final UserModel user; // Add this line
  final String? profileImageUrl;

  const DashboardFreelance({Key? key, required this.user, this.profileImageUrl}) ;
  @override
  State<DashboardFreelance> createState() => _DashboardFreelanceState();
}


class _DashboardFreelanceState extends State<DashboardFreelance> {
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
  final TextEditingController professionalroleController = TextEditingController();


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
        child: CoverImageUrl != null
            ? Image.network(
          CoverImageUrl!,
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
            SizedBox(width: 5,),
            Icon(
              Icons.facebook,
              color: Colors.white,
              size: 15,
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
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

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Add the background image here
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Dashboard.png'),
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
                  '${widget.user.firstName} ${widget.user.lastName}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16056B),
                  ),
                ),
                Text(
                  'Top Level Freelancer',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4B4646),
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
                SizedBox(height: 24,),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DataDetailsScreenFreelancer(user: widget.user,profileImageUrl: widget.profileImageUrl),
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
                        builder: (context) =>  BalanceFreelancer(user: widget.user,profileImageUrl: widget.profileImageUrl),
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
                        builder: (context) => TransactionhistoryFreelancer(user: widget.user,profileImageUrl: widget.profileImageUrl),
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
                0.60, // Adjust this value for desired alignment
            left: (screenWidth - 360) / 2,
            child: SizedBox(
              width: 360,
              child: Divider(
                color: Color(0xFF969595),
                thickness: 0.7,
              ),
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
                        builder: (context) =>  HelpFreelancer(user: widget.user,profileImageUrl: widget.profileImageUrl),
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
                        builder: (context) =>  InviteFriendsFreelancer(user: widget.user,profileImageUrl: widget.profileImageUrl),
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
                        builder: (context) => TermsandConditionsFreelancer(user: widget.user,profileImageUrl: widget.profileImageUrl),
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
    );
  }
  Future<String> uploadProfileImage1(File imageFile) async {
    final Reference storageRef = FirebaseStorage.instance.ref().child('cover_image/${imageFile.path.split('/').last}');

    final TaskSnapshot uploadTask = await storageRef.putFile(imageFile);
    final String downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }
}
