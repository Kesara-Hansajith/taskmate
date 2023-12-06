import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmate/classes/cus_snackbar.dart';
import 'package:taskmate/components/attachment_card.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/components/review_card.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/dashboard/freelancer/add_portfolio_item.dart';
import 'package:file_picker/file_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController professionalRoleController =
      TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController overviewController = TextEditingController();

  String userId = '';
  final picker = ImagePicker();
  late String _imageUrl;

  // String professionalRole='';
  // String hourlyRate='';
  // String bio='';

  // Future<void> openFilePicker() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType
  //           .any, // You can specify the file types to allow (e.g., FileType.image, FileType.pdf, etc.)
  //       allowMultiple:
  //           true, // Set to true if you want to allow multiple file selection
  //     );
  //
  //     if (result != null) {
  //       List<String> filePaths = result.paths.map((path) => path!).toList();
  //       // You now have the selected file paths in the `filePaths` list
  //       print('Selected files: $filePaths');
  //     } else {
  //       // User canceled the file picker
  //     }
  //   } catch (e) {
  //     // Handle any exceptions that may occur during file picking
  //     print('Error picking files: $e');
  //   }
  // }

  void fetchDetails(String proRole, String hrRate, String over) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId) // Reference to the specific user document
        .update({
          'professionalRole': proRole,
          'hourlyRate': hrRate,
          'bio': over,
        })
        .then((value) {})
        .catchError((error) {
          // print('Failed to update user role: $error');
        });
  }

  void updateUserDetails() {
    String professionalRole = professionalRoleController.text.trim();
    String hourlyRate = hourlyRateController.text.trim();
    String bio = overviewController.text.trim();

    fetchDetails(professionalRole, hourlyRate, bio);
  }

  void _navigateAddPortfolioItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddPortfolioItem(),
      ),
    );
  }

  Future<void> fetchImageURL() async {
    try {
      // Fetch the user document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      // Get the current image URL
      setState(() {
        _imageUrl = userDoc['photoUrl'] ??
            ''; // If 'photoUrl' doesn't exist, set it to an empty string
      });
    } catch (e) {
      print('Error fetching image URL: $e');
    }
  }

  Future<void> updateImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          CusSnackBar(
            backColor: kSuccessGreenColor,
            time: 5,
            title: 'Uploading...',
            icon: Icons.upload,
          ),
        );
      }

      // Upload the selected file to Firebase Storage
      Reference ref =
          FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
      UploadTask uploadTask = ref.putData(File(file.path!).readAsBytesSync());

      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      // Update the Firestore document with the new image URL
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update({'profilePhotoUrl': downloadUrl});

      setState(() {
        _imageUrl = downloadUrl; // Update the image URL in the UI
      });
    }
  }

  Future<Map<String, dynamic>> fetchData() async {
    User? user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    // Define the Firestore collection, document ID, and fields you want to retrieve.
    final DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return data;
  }

  void _navigateBackwards() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    professionalRoleController.dispose();
    hourlyRateController.dispose();
    overviewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchImageURL();
    super.initState();
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
            image: AssetImage(
              'images/noise_image.webp',
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: <Container>[
                    Container(
                      width: screenWidth,
                      height: screenHeight / 5,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'images/cover_photo.webp',
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          // Container(
                          //   margin: const EdgeInsets.all(8.0),
                          //   decoration: const BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: kBrilliantWhite,
                          //   ),
                          //   child: IconButton(
                          //     onPressed: openFilePicker,
                          //     icon: const Icon(
                          //       Icons.add_photo_alternate,
                          //       size: 25.0,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight / 15,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                Stack(
                  //alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 5.0, // Set the border width
                        ),
                      ),
                      child: FutureBuilder(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              backgroundImage: NetworkImage(
                                '${snapshot.data?['profilePhotoUrl']}',
                              ),
                              radius: 40,
                            );
                          } else {
                            return const SpinKitFadingCircle(
                              color: kDeepBlueColor,
                              size: 30.0,
                            );
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 35.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kBrilliantWhite,
                        ),
                        child: IconButton(
                          onPressed: updateImage,
                          icon: const Icon(
                            Icons.add_photo_alternate,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   'Good Morning!',
                  //   style:
                  //       kJobCardTitleTextStyle.copyWith(color: kAmberColor),
                  // ),
                  FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Text(
                            '${snapshot.data?['firstName']} ${snapshot.data?['lastName']}',
                            style: kSubHeadingTextStyle,
                          ),
                        );
                      } else {
                        return const SpinKitThreeBounce(
                          color: kDeepBlueColor,
                          size: 30.0,
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data?['Level']} Level Freelancer',
                          style: kTextStyle.copyWith(color: kOceanBlueColor),
                        );
                      } else {
                        return const SpinKitThreeBounce(
                          color: kDeepBlueColor,
                          size: 30.0,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UserDataGatherTitle(
                          title: 'Professional Role',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: TextFormField(
                              controller: professionalRoleController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                hintText: 'Professional Role here',
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
                                  return 'Field can\'t be empty';
                                }
                              }),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                        //   child: Text(
                        //     'Professional Role - Logo Designer | Digital Artist | Graphic Designer ',
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                        const UserDataGatherTitle(
                          title: 'Hourly Rate',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            controller: hourlyRateController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: 'LKR ',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              hintText: 'Your Hourly Rate here',
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
                                return 'Field can\'t be empty';
                              }
                            },
                          ),
                          // const UserDataGatherTitle(
                          //   title: 'Hourly Rate : LKR. 1000',
                          // ),
                        ),
                        const UserDataGatherTitle(title: 'Overview'),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: TextFormField(
                              controller: overviewController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                hintText: 'Enter overview',
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
                                  return 'Field can\'t be empty';
                                }
                              }),
                          // Text(
                          //   'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
                          //   style: kTextStyle,
                          // ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            width: screenWidth / 1.2,
                            child: const Divider(
                              color: kDarkGreyColor,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        const UserDataGatherTitle(
                          title: 'Portfolio',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Material(
                                      child: InkWell(
                                        onTap: _navigateAddPortfolioItem,
                                        child: const AttachmentCard(
                                          cardChild: Text('+ Add'),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text('Project Title'),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        //TODO Implement delete functionality
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Material(
                                      child: InkWell(
                                        onTap: _navigateAddPortfolioItem,
                                        child: const AttachmentCard(
                                          cardChild: Text('+ Add'),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text('Project Title'),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        //TODO Implement delete functionality
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            width: screenWidth / 1.2,
                            child: const Divider(
                              color: kDarkGreyColor,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        const UserDataGatherTitle(
                          title: 'Reviews',
                        ),
                        const ReviewCard(
                          imagePath: 'images/blank_profile.webp',
                          jobTitle: 'Graphic designer for family care product',
                          feedback:
                              'Great! Very creative and had great ideas! ',
                          username: 'Nugera Gomez',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: LightMainButton(
                                  title: 'Cancel',
                                  process: _navigateBackwards,
                                ),
                              ),
                              Expanded(
                                child: DarkMainButton(
                                  title: 'Save',
                                  process: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Form is valid, proceed with submission or other actions
                                      updateUserDetails();
                                      _navigateBackwards();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
