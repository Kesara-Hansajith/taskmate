import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_textfield.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_2.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/freelancer/user_data_gather_function.dart';
import 'package:taskmate/profile/freelancer/user_repository.dart';

class ProfileFreelancer extends StatefulWidget {
  const ProfileFreelancer({Key? key}) : super(key: key);

  @override
  _ProfileFreelancerState createState() => _ProfileFreelancerState();
}

class _ProfileFreelancerState extends State<ProfileFreelancer> {
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
  final TextEditingController levelController = TextEditingController();
  final TextEditingController imageurl2Controller = TextEditingController();
  final TextEditingController imageurl3Controller = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController itemdesController = TextEditingController();
  final TextEditingController verifyController = TextEditingController();

  String existingUserId = 'your_existing_user_id';
  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;
  bool _isPasswordVisible = false;

  get emailRegex => RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        caseSensitive: false,
        multiLine: false,
      );
  get phoneRegex => RegExp(
        r'^[0-9]{10}$',
        caseSensitive: false,
        multiLine: false,
      );
  final _city1Regex = RegExp(r'^[a-zA-Z]+$');

  void selectDate(
      BuildContext context, TextEditingController birthdayController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      birthdayController.text = formattedDate; // Update the text field
    }
  }

  void updateData() {
    if (formKey.currentState!.validate()) {
      setState(() {
        dataSubmitted = true;
      });
    }
  }

  void _selectGender() async {
    final selectedValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Gender'),
          content: DropdownButtonFormField<String>(
            value: selectedGender,
            items: const [
              DropdownMenuItem(
                value: 'Male',
                child: Text('Male'),
              ),
              DropdownMenuItem(
                value: 'Female',
                child: Text('Female'),
              ),
              DropdownMenuItem(
                value: 'Other',
                child: Text('Other'),
              )
            ],
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, selectedGender);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    if (selectedValue != null) {
      genderController.text = selectedValue;
    }
  }

  void _selectProvince() async {
    final selectedValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Province'),
          content: DropdownButtonFormField<String>(
            value: selectedProvince,
            items: const [
              DropdownMenuItem(
                value: 'Central Province',
                child: Text('Central Province'),
              ),
              DropdownMenuItem(
                value: 'Eastern Province',
                child: Text('Eastern province'),
              ),
              DropdownMenuItem(
                value: 'North Central Province',
                child: Text('North Central Province'),
              ),
              DropdownMenuItem(
                value: 'North Western Province',
                child: Text('North Western Province'),
              ),
              DropdownMenuItem(
                value: 'Northern Province',
                child: Text('Northern Province'),
              ),
              DropdownMenuItem(
                value: 'Sabaragamuwa Province',
                child: Text('Sabaragamuwa Province'),
              ),
              DropdownMenuItem(
                value: 'Southern Province',
                child: Text('Southern Province'),
              ),
              DropdownMenuItem(
                value: 'Uva Province',
                child: Text('Uva Province'),
              ),
              DropdownMenuItem(
                value: 'Western Province',
                child: Text('Western Province'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedProvince = value;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, selectedProvince);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    if (selectedValue != null) {
      provinceController.text = selectedValue;
    }
  }

  void _routeToNextPage() async {
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
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        professionalRole: professionalroleController.text.trim(),
        province: provinceController.text.trim(),
        bio: bioController.text.trim(),
        hourlyRate: hourlyrateController.text.trim(),
        skills: skillsController.text.trim(),
        services: servicesController.text.trim(),
        sociallink: sociallinkController.text.trim(),
        city: cityController.text.trim(),
        phoneNo: phoneController.text.trim(),
        profilePhotoUrl: profileImageUrl,
        verify: '',
      );
      // Get the authenticated user's UID
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? firebaseUser = _auth.currentUser;

      if (firebaseUser != null) {
        final String userUid = firebaseUser.uid;

        // Use the user's UID as the Firestore document ID
        await UserRepository.instance.createUser(user, userUid);
      } else {
        // Handle the case where the user is not authenticated
        // You may want to display an error message or redirect the user to the login page
      }
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileFreelancer2(user: user),
          ),
        );
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  ),
                  const UserDataGatherTitle(
                    title: 'Your Name*',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: UserDataGatherTextField(
                            controller: firstNameController,
                            hintText: 'First Name',
                            validatorText: 'Enter First Name',
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: UserDataGatherTextField(
                            controller: lastNameController,
                            hintText: 'Last Name',
                            validatorText: 'Enter Last Name',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const UserDataGatherTitle(title: 'Birthday*'),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: TextFormField(
                                  controller: birthdayController,
                                  onTap: () {
                                    selectDate(context,
                                        birthdayController); // Show the date picker on tap
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10.0),
                                    hintText: 'Birthday',
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
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        selectDate(context,
                                            birthdayController); // Show the date picker on icon tap
                                      },
                                      child: const Icon(
                                        Icons.calendar_today,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please select your birthday';
                                    }
                                    DateTime selectedDate = DateTime.parse(
                                        value); // Convert selected value to DateTime
                                    DateTime currentDate = DateTime.now();
                                    DateTime minValidDate =
                                        currentDate.subtract(const Duration(
                                            days: 365 * 18)); // 18 years ago

                                    if (selectedDate.isAfter(minValidDate)) {
                                      return 'You must be 18 years or older';
                                    }
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const UserDataGatherTitle(title: 'Gender*'),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: UserDataGatherFunction(
                                controller: genderController,
                                hintText: 'Tap Here',
                                validatorText: 'Select Gender',
                                icon: Icons.arrow_drop_down,
                                function: () {
                                  _selectGender();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserDataGatherTitle(title: 'Email*'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: 'Email',
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
                              return 'Please enter your Email';
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const UserDataGatherTitle(title: 'Address*'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        UserDataGatherTextField(
                            controller: addressController,
                            hintText: 'Apartment/Suite Number',
                            validatorText: 'Enter Apartment Name'),
                        const SizedBox(
                          height: 6.0,
                        ),
                        UserDataGatherTextField(
                            controller: streetController,
                            hintText: 'Street Name',
                            validatorText: 'Enter Street Name'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const UserDataGatherTitle(title: 'City*'),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: TextFormField(
                                controller: cityController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  hintText: 'City',
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
                                    return 'Enter City';
                                  }
                                  if (!_city1Regex.hasMatch(value)) {
                                    return 'Please enter a valid City';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const UserDataGatherTitle(title: 'State/Province*'),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: UserDataGatherFunction(
                                controller: provinceController,
                                hintText: 'Tap Here',
                                validatorText: 'Select a Province',
                                icon: Icons.arrow_drop_down,
                                function: () {
                                  _selectProvince();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  const UserDataGatherTitle(title: 'ZIP/Postal code*'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: zipCodeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+$'),
                        ),
                      ],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Zip Code',
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
                          return 'Enter Zipcode';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  const UserDataGatherTitle(title: 'Phone number*'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Ex: 07x xxx xxxx',
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
                          return 'Enter phone number';
                        } else if (value.length != 10) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const UserDataGatherTitle(title: 'Professional Role*'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: professionalroleController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Add your professional roll here',
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
                          return 'Please enter your professional role';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DarkMainButton(
                        title: 'Save & Next',
                        process: () {
                          _routeToNextPage();
                        },
                        screenWidth: screenWidth),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
