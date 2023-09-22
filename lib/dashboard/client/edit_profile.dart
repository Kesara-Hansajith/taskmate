import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/components/review_card.dart';
import 'package:taskmate/constants.dart';
import 'package:file_picker/file_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // final _formKey = GlobalKey<FormState>();
  // final TextEditingController professionalRoleController =
  //     TextEditingController();

  Future<void> openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType
            .any, // You can specify the file types to allow (e.g., FileType.image, FileType.pdf, etc.)
        allowMultiple:
            true, // Set to true if you want to allow multiple file selection
      );

      if (result != null) {
        List<String> filePaths = result.paths.map((path) => path!).toList();
        // You now have the selected file paths in the `filePaths` list
      } else {
        // User canceled the file picker
      }
    } catch (e) {
      // Handle any exceptions that may occur during file picking
    }
  }

  void _navigateBackwards() {
    Navigator.of(context).pop();
  }

  // @override
  // void dispose() {
  //   professionalRoleController.dispose();
  //   super.dispose();
  // }

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
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kBrilliantWhite,
                              ),
                              child: IconButton(
                                onPressed: openFilePicker,
                                icon: const Icon(
                                  Icons.add_photo_alternate,
                                  size: 25.0,
                                ),
                              ),
                            ),
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
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/blank_profile.webp',
                          ),
                          radius: 40,
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
                            onPressed: openFilePicker,
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
                    Text(
                      'Nimali Ihalagama',
                      style: kSubHeadingTextStyle,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        UserDataGatherTitle(
                          title: 'Reviews',
                        ),
                        ReviewCard(
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
                                    // if (_formKey.currentState!.validate()) {
                                    // Form is valid, proceed with submission or other actions
                                    _navigateBackwards();
                                    // }
                                    //TODO Implement Save feature
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
