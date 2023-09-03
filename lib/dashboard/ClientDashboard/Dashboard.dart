import 'package:flutter/material.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/Balance.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/Help.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/Transactionhistory.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/invitefriends.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/termsandconditions.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/Dragtoadjust.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskmate/profile/freelancer/data_details_screen_freelancer.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/profile/freelancer/user_repository.dart';
import 'dart:io';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController professionalroleController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController servicesController = TextEditingController();
  final TextEditingController hourlyrateController = TextEditingController();
  final TextEditingController imageurl1Controller = TextEditingController();
  final TextEditingController imageurl2Controller = TextEditingController();
  final TextEditingController imageurl3Controller = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController itemdesController = TextEditingController();


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
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () async {
                final imageFile = await _pickProfileImage();
                if (imageFile != null) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Dragtoadjust(imageFile: imageFile),
                      transitionDuration:
                          Duration(seconds: 0), // No transition animation
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
            child: buildProfileImage(),
          ),
          Positioned(
            bottom:
                screenSize.height * 0.60, // Adjust position for greeting text
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                getGreeting(),
                style: TextStyle(
                  fontSize: 15,
                  color: kAmberColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Positioned(
            top: screenSize.height *
                0.4, // Adjust this value for desired alignment
            left: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    // Validated successfully, submit the form
                    final user = UserModel(
                      firstName: firstNameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                      address: addressController.text.trim(),
                      zipcode: zipCodeController.text.trim(),
                      street: streetController.text.trim(),
                      birthday: birthdayController.text.trim(),
                      gender: genderController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      professionalrole: professionalroleController.text.trim(),
                      province: provinceController.text.trim(),
                      bio: bioController.text.trim(),
                      hourlyRate: hourlyrateController.text.trim(),
                      skills: skillsController.text.trim(),
                      services: servicesController.text.trim(),
                      sociallink: sociallinkController.text.trim(),
                      city: cityController.text.trim(),
                      phoneNo: phoneController.text.trim(),
                      profilePhotoUrl: profileImageUrl,
                    );
                    UserRepository.instance.createUser(user);

                    Navigator.pop(context);
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DataDetailsScreenFreelancer(user: user),
                      ),
                    );// Handle button press
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
                        builder: (context) => const Balance(),
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
                        builder: (context) => const Transactionhistory(),
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
                0.57, // Adjust this value for desired alignment
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
                        builder: (context) => const Help(),
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
                        builder: (context) => const InviteFriends(),
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
                        builder: (context) => const TermsandConditions(),
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
