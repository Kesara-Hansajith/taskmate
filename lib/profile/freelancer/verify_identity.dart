//import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/navigate_before.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/components/verify_identity_card.dart';
import 'package:taskmate/components/verifyidentity_outlinedbutton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:taskmate/components/snackbar.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/freelancer_home_page.dart';

class VerifyIdentity extends StatefulWidget {
  const VerifyIdentity({super.key});

  @override
  State<VerifyIdentity> createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends State<VerifyIdentity> {


  bool isIDSubmitted = false;
  bool isPhotoSubmitted = false;
  bool isLoading = false;

  void pickIDFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          isIDSubmitted = true;
          // Do something with the file...
        });
      } else {
        // Handle the case where filePath is null (unlikely)
      }
    } else {
      // User canceled the picker
    }
  }

  void pickSelfiePhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          isPhotoSubmitted = true;
          // Do something with the file...
        });
      } else {
        // Handle the case where filePath is null (unlikely)
      }
    } else {
      // User canceled the picker
    }
  }

  void submitDocuments() {
    if (isIDSubmitted == true && isPhotoSubmitted == true) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return MaintenancePage(
            [
              const Image(
                image: AssetImage('images/clock.webp'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Congratulations!',
                  textAlign: TextAlign.center,
                  style: kSubHeadingTextStyle.copyWith(height: 0.5),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Your account will be activated \nwithin 1 business day. We will notify you by \nemail after activation.',
                  style: kTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              DarkMainButton(
                  title: 'Back To Home',
                  process: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const FreelancerHomePage(),
                      ),
                    );
                  },
                  screenWidth: MediaQuery.of(context).size.width)
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar('Submit all the Documents'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                  outlineColor:
                      isIDSubmitted ? (kDeepBlueColor) : (kOceanBlueColor),
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
                  subFontColor:
                      isIDSubmitted ? (kBrilliantWhite) : (kDarkGreyColor),
                  docSubmitButton: isIDSubmitted
                      ? null
                      : (VerifyIdentityOutlinedButton(
                          function: pickIDFile, hyperlinkText: 'Add Document')),
                ),
              ),
              Expanded(
                flex: 2,
                child: VerifyIdentityCard(
                  bgColor: isPhotoSubmitted
                      ? (kDeepBlueColor)
                      : (const Color.fromARGB(102, 180, 215, 254)),
                  outlineColor:
                      isPhotoSubmitted ? (kDeepBlueColor) : (kOceanBlueColor),
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
                  subFontColor:
                      isPhotoSubmitted ? (kBrilliantWhite) : (kDarkGreyColor),
                  docSubmitButton: isPhotoSubmitted
                      ? (null)
                      : VerifyIdentityOutlinedButton(
                          function: pickSelfiePhoto,
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
                process: submitDocuments,
                screenWidth: screenWidth,
              ),
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
