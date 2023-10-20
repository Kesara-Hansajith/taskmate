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
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/components/navigate_before.dart';
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

  List<String> uploadedImageUrls = [];

  Future<void> savePortfolioItemToFirestore() async {
    try {
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
      // Create a document in Firestore containing the uploaded image URLs
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

        // Get the current user
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final User? firebaseUser = _auth.currentUser;

        if (firebaseUser != null) {
          final String userUid = firebaseUser.uid;

          // Create a reference to the user's document
          final DocumentReference userDocRef =
              FirebaseFirestore.instance.collection('Users').doc(userUid);

          // Fetch the current counter value and increment it
          final DocumentSnapshot userDocSnapshot = await userDocRef.get();
          final Map<String, dynamic>? userData =
              userDocSnapshot.data() as Map<String, dynamic>?;
          int counter = userData?['portfolio_counter'] ?? 0;
          counter++;

          // Add the portfolio item with the custom ID
          await userDocRef
              .collection('portfolio_items')
              .doc(counter.toString())
              .set({
            'title': titleController.text.trim(),
            'item_description': itemdesController.text.trim(),
            'image_urls': uploadedImageUrls,
            'timestamp': FieldValue.serverTimestamp(),
          });

          // Update the counter in the user's document
          await userDocRef.update({'portfolio_counter': counter});

          Navigator.pop(context);
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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: const NavigateBefore(
            size: 35.0,
          ),
          flexibleSpace: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'images/noise_image.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          title: Text(
            'Add Portfolio Items',
            style: kHeadingTextStyle.copyWith(fontSize: 30),
          ),
        ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DarkMainButton(
                                title: '+ Add',
                                process: pickImages,
                                screenWidth: screenWidth),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.radio_button_checked,
                                      size: 9.0,
                                    ),
                                    Text(
                                      ' Allowed formats -JPG, PNG',
                                      style: kTextStyle.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.radio_button_checked,
                                      size: 9.0,
                                    ),
                                    Text(
                                      ' Maximum file size 10MB',
                                      style: kTextStyle.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Wrap(
                            spacing: 10,
                            children:
                                selectedImages.asMap().entries.map((entry) {
                              final index = entry.key;
                              final image = entry.value;
                              return MouseRegion(
                                onHover: (event) {
                                  // Show delete icon when hovering
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Delete Image'),
                                      content: Text(
                                          'Are you sure you want to delete this image?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedImages.removeAt(index);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Stack(
                                    children: [
                                      Image.file(image, height: 80),
                                      // Add an Icon to represent delete
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Icon(
                                          Icons.delete_outlined,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LightMainButton(
                            title: 'Cancel',
                            process: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Expanded(
                        child: DarkMainButton(
                            title: 'Save & Next',
                            process: _routeToNextPage,
                            screenWidth: screenWidth),
                      ),
                    ],
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
