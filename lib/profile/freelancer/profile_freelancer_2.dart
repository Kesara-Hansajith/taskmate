import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/navigate_before.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_3.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/profile/freelancer/user_repository.dart';

import '../../constants.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';

class ProfileFreelancer2 extends StatefulWidget {
  final UserModel user;

  const ProfileFreelancer2({super.key, required this.user});

  @override
  _ProfileFreelancer2State createState() => _ProfileFreelancer2State();
}

class _ProfileFreelancer2State extends State<ProfileFreelancer2> {
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
  final TextEditingController levelController = TextEditingController();

  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;

  String? get existingUserId => null;
  List<String> selectedServices = [];

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
        hourlyRate: hourlyrateController.text,
        bio: bioController.text,
        sociallink: sociallinkController.text,
        skills: skillsController.text,
        services: servicesController.text,
        email: widget.user.email,
        password: widget.user.password,
        professionalRole: widget.user.professionalRole,
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
            builder: (context) => ProfileFreelancer3(user: updatedUser),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const NavigateBefore(size: 50.0),
                      SizedBox(width: screenWidth / 10),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserDataGatherTitle(title: 'Hourly rate*'),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18.0),
                        width: screenWidth / 2,
                        child: TextFormField(
                          controller: hourlyrateController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+$')),
                          ],
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: '00.00',
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
                              return 'Please enter your Hourly rate ';
                            }
                            double? hourlyRate = double.tryParse(value);
                            if (hourlyRate == null || hourlyRate < 700) {
                              return 'lowest amount LKR 700';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const UserDataGatherTitle(title: 'Your overview*'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: bioController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Add an Overview',
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
                      maxLines: 8,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your overview';
                        } else if (value.length < 100) {
                          return 'Please enter at least 100 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const UserDataGatherTitle(title: 'Your skills'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: skillsController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Enter at least 5 skills',
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
                          return 'Please enter your skills';
                        }
                        final skillsList = value
                            .split(',')
                            .map((skill) => skill.trim())
                            .toList();

                        if (skillsList.length < 5) {
                          return 'Please enter up to 5 skills';
                        }
                        return null;
                      },
                    ),
                  ),
                  const UserDataGatherTitle(title: 'Your main services'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: servicesController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Search for services',
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
                          return 'Please enter your service ';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 35.0), // Add horizontal padding
                    child: Text(
                      '-Selected Services',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B4646), // Adjust the color as needed
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Service 1 and Service 2 side by side
                      GestureDetector(
                        onTap: () => selectService('Logos and branding'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 26.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Adjust the padding
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: kDarkGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Logos and branding',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () => selectService('Infographics design'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Adjust the padding
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: kDarkGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Infographics design',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Service 1 and Service 2 side by side
                      GestureDetector(
                        onTap: () => selectService('Website/blog design'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 26.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Adjust the padding
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: kDarkGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Website/blog design',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => selectService('Print design'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Adjust the padding
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: kDarkGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Print design',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Service 1 and Service 2 side by side
                      GestureDetector(
                        onTap: () => selectService('Podcast cover art design'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 26.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Adjust the padding
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: kDarkGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Podcast cover art design',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => selectService('Photoshop design'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), // Adjust the padding
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: kDarkGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Photoshop design',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DarkMainButton(
                      title: 'Save & Next',
                      process: _routeToNextPage,
                      screenWidth: screenWidth),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void selectService(String serviceName) {
    setState(() {
      selectedServices.add(serviceName);
      servicesController.text =
          selectedServices.join(', '); // Update the text field
    });
  }
}
