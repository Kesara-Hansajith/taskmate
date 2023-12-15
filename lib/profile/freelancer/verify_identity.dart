//import 'package:camera/camera.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/loading_screen.dart';
import 'package:taskmate/components/navigate_before.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/components/verify_identity_card.dart';
import 'package:taskmate/components/verifyidentity_outlinedbutton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:taskmate/components/snackbar.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/freelancer_home_page.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/profile/freelancer/verification_pending.dart';

class VerifyIdentity extends StatefulWidget {
  const VerifyIdentity({
    super.key,
    required this.userUid,
    required this.user,
    required this.downloadUrl,
  });
  final UserModel user;
  final String userUid;
  final String downloadUrl;

  @override
  State<VerifyIdentity> createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends State<VerifyIdentity> {
  bool isIDSubmitted = false;
  bool isPhotoSubmitted = false;
  bool isLoading = false;
  File? selectedImage0;
  File? selectedImage1;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  String? _uploadedImageUrl;

  void govId() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Upload image to Firebase Storage and get the download URL

      // Refresh the UI if needed
      setState(() {
        selectedImage0 = File(pickedImage.path);
        isIDSubmitted = true;
      });
    }
  }

  void selfie() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Upload image to Firebase Storage and get the download URL

      // Refresh the UI if needed
      setState(() {
        selectedImage1 = File(pickedImage.path);
        isPhotoSubmitted = true;
      });
    }
  }

  Future<String> uploadGovId(File imageFile) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('governmentIDs/${widget.userUid}.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask;

      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      return '';
    }
  }

  Future<String> uploadSelfieId(File imageFile) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('verifySelfies/${widget.userUid}.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask;

      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      return '';
    }
  }

  void _submitDetails() async {
    setState(() {
      isLoading = true;
    });
    if (selectedImage0 != null) {
      // Upload image to Firebase Storage and get the download URL
      final String govIdUrl = await uploadGovId(selectedImage0!);

      final String selfieUrl = await uploadSelfieId(selectedImage1!);

      // Get the current user's UID from Firebase Authentication
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? firebaseUser = _auth.currentUser;

      if (firebaseUser != null) {
        // Use the user's UID as the Firestore document ID
        final String userUid = firebaseUser.uid;

        // Create a Firestore document and save the data
        await FirebaseFirestore.instance.collection('Users').doc(userUid).set(
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
            'profilePhotoUrl': widget.downloadUrl,
            'verify': widget.user.verify,
            'govIdUrl': govIdUrl,
            'selfieUrl': selfieUrl,
          },
        );

        setState(() {
          isLoading = false;
        });

        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => VerificationPending(
                userUid: userUid,
                user: widget.user,
              ),
              //builder: (context) =>  VerifyIdentity(),
            ),
          );
        }
      }
    }
  }

  // void submitDocuments() {
  //   if (isIDSubmitted == true && isPhotoSubmitted == true) {
  //     showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return MaintenancePage(
  //           [
  //             const Image(
  //               image: AssetImage('images/clock.webp'),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 12.0),
  //               child: Text(
  //                 'Congratulations!',
  //                 textAlign: TextAlign.center,
  //                 style: kSubHeadingTextStyle.copyWith(height: 0.5),
  //               ),
  //             ),
  //             const Padding(
  //               padding: EdgeInsets.symmetric(vertical: 8.0),
  //               child: Text(
  //                 'Your account will be activated \nwithin 1 business day. We will notify you by \nemail after activation.',
  //                 style: kTextStyle,
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //             DarkMainButton(
  //                 title: 'Back To Home',
  //                 process: () {
  //                   Navigator.of(context).pushReplacement(
  //                     MaterialPageRoute(
  //                       builder: (context) => const FreelancerHomePage(),
  //                     ),
  //                   );
  //                 },
  //                 screenWidth: MediaQuery.of(context).size.width)
  //           ],
  //         );
  //       },
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       CustomSnackBar('Submit all the Documents'),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: !isLoading
          ? Scaffold(
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
                  'Verify Your Identity',
                  style: kHeadingTextStyle.copyWith(fontSize: 30),
                ),
              ),
              body: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/noise_image.webp'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: VerifyIdentityCard(
                        bgColor: isIDSubmitted
                            ? (kDeepBlueColor)
                            : (const Color.fromARGB(102, 180, 215, 254)),
                        outlineColor: isIDSubmitted
                            ? (kDeepBlueColor)
                            : (kOceanBlueColor),
                        icon: isIDSubmitted
                            ? (Icons.done_outline)
                            : (Icons.contact_mail),
                        backCircleColor:
                            isIDSubmitted ? (kAmberColor) : (kDeepBlueColor),
                        headingText: 'Government ID',
                        headFontColor:
                            isIDSubmitted ? (kAmberColor) : (kDeepBlueColor),
                        subText:
                            'Upload a national identity card, \ndriver’s license or passport photo',
                        subFontColor: isIDSubmitted
                            ? (kBrilliantWhite)
                            : (kDarkGreyColor),
                        docSubmitButton: isIDSubmitted
                            ? null
                            : (VerifyIdentityOutlinedButton(
                                function: govId,
                                hyperlinkText: 'Add Document')),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: VerifyIdentityCard(
                        bgColor: isPhotoSubmitted
                            ? (kDeepBlueColor)
                            : (const Color.fromARGB(102, 180, 215, 254)),
                        outlineColor: isPhotoSubmitted
                            ? (kDeepBlueColor)
                            : (kOceanBlueColor),
                        icon: isPhotoSubmitted
                            ? (Icons.done_outline)
                            : (Icons.add_a_photo),
                        backCircleColor:
                            isPhotoSubmitted ? (kAmberColor) : (kDeepBlueColor),
                        headingText: 'Selfie Photo',
                        headFontColor:
                            isPhotoSubmitted ? (kAmberColor) : (kDeepBlueColor),
                        subText:
                            'Take picture of your self to identity and \nfacial verification',
                        subFontColor: isPhotoSubmitted
                            ? (kBrilliantWhite)
                            : (kDarkGreyColor),
                        docSubmitButton: isPhotoSubmitted
                            ? (null)
                            : VerifyIdentityOutlinedButton(
                                function: selfie,
                                hyperlinkText: 'Take Photo',
                              ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(
                          // height: 50.0,
                          ),
                    ),
                    DarkMainButton(
                      title: 'Submit Documents',
                      process: _submitDetails,
                      screenWidth: screenWidth,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            )
          : const LoadingScreen(title: 'Uploading Proofs . . .'),
    );
  }
}
