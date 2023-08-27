import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_textfield.dart';
import '../../constants.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';

class ProfileFreelancer4 extends StatefulWidget {
  //final UserModel user;
  const ProfileFreelancer4({Key? key}) : super(key: key);
  //const ProfileFreelancer4({required  this.user}) ;

  @override
  _ProfileFreelancer4State createState() => _ProfileFreelancer4State();
}

class _ProfileFreelancer4State extends State<ProfileFreelancer4> {
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

  List<File> selectedImages = [];

  String existingUserId = 'your_existing_user_id';
  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;

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

  get user => existingUserId;

  Future<void> pickImages() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage(
        imageQuality: 85,
      );

      if (pickedFiles != null) {
        setState(() {
          selectedImages
              .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
        });
      }
    } catch (e) {
      //Ignored catch block
    }
  }

  Future<void> savePortfolioItemToFirestore() async {
    try {
      List<String> uploadedImageUrls = [];

      for (int i = 0; i < selectedImages.length; i++) {
        final imageFile = selectedImages[i];
        final imageName = path.basename(imageFile.path);
        final storageRef = firebase_storage.FirebaseStorage.instance.ref().child(
            'portfolio_images/${DateTime.now().millisecondsSinceEpoch}/$imageName');

        final uploadTask = storageRef.putFile(imageFile);
        final taskSnapshot = await uploadTask;
        if (taskSnapshot.state == firebase_storage.TaskState.success) {
          final imageUrl = await taskSnapshot.ref.getDownloadURL();
          uploadedImageUrls.add(imageUrl);
        }
      }

      await FirebaseFirestore.instance.collection('portfolio_items').add({
        'title': titleController.text,
        'item_description': itemdesController.text,
        'image_urls': selectedImages.map((image) => image.path).toList(),
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      //Ignored catch block
    }
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    checkAuthentication(); // You can call your authentication check function here
  }

  void checkAuthentication() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Redirect the user to the login page or show an authentication prompt
      // This could be done using Navigator or other methods
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
      // Validated successfully, submit the form

      await savePortfolioItemToFirestore();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Portfolio item saved.'),
          ),
        );

        Navigator.pop(context);
      }
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ProfileFreelancer2(user: user),
      //   ),
      // );
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
                  const Center(
                    child: Text(
                      'Add Portfolio Item',
                      style: kHeadingTextStyle,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const UserDataGatherTitle(title: 'Title'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: UserDataGatherTextField(
                            controller: titleController,
                            hintText: 'Add the Title',
                            validatorText: 'Field can\'t be empty'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserDataGatherTitle(title: 'Item description'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: TextFormField(
                          controller: itemdesController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: 'Add your portfolio item description',
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
                              return 'Field can\'t be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserDataGatherTitle(title: 'Upload files'),
                      SizedBox(
                        width: screenWidth / 2,
                        child: DarkMainButton(
                            title: 'Add',
                            process: pickImages,
                            screenWidth: screenWidth),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Wrap(
                          spacing: 10,
                          children: selectedImages
                              .map(
                                (image) => Image.file(image, height: 80),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  DarkMainButton(
                      title: 'Save & Next',
                      process: _routeToNextPage,
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
