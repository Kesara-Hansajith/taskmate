import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:taskmate/client_home_page.dart';
import 'package:taskmate/components/attachment_card.dart';

import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_textfield.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/constants.dart';
// import 'package:taskmate/profile/client/user_model1.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

class ClientPostJob extends StatefulWidget {
  const ClientPostJob({
    // required this.client,
    Key? key,
  });

  // final UserModel1 client;

  @override
  State<ClientPostJob> createState() => _ClientPostJobState();
}

class _ClientPostJobState extends State<ClientPostJob> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  late final audioFile;

  // final audioPlayer = AudioPlayer();
  // bool isPlaying = false;
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;

  final formKey = GlobalKey<FormState>();

  final List<String> _skills = [];
  // String _skillsText = '';

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController dayCountController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  File? _selectedImage1;
  File? _selectedImage2;

  // Future<void> playAudioFromUrl(String url)async{
  //   await audioPlayer.play(UrlSource(url));
  // }

  @override
  void dispose() {
    // Dispose of the text controllers to prevent memory leaks
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    dayCountController.dispose();
    budgetController.dispose();
    recorder.closeRecorder();
    // recorder.dispose();
    super.dispose();
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    audioFile = File(path!);
    print('Recorded voice: $audioFile');
  }

  void selectService(String serviceName) {
    setState(() {
      _skills.add(serviceName);
      skillController.text = _skills.join(', '); // Update the text field
    });
  }

  Future<void> uploadFile(int imageNumber) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File selectedImage = File(result.files.single.path!);
        setState(() {
          if (imageNumber == 1) {
            _selectedImage1 = selectedImage;
          } else if (imageNumber == 2) {
            _selectedImage2 = selectedImage;
          }
        });
      }
    } catch (e) {
      // Handle errors
    }
  }

  Future<void> addJobToFirestore(
    String jobTitle,
    String jobDescription,
    int dayCount,
    int budget,
  ) async {
    try {
      // Get the current user's UID from FirebaseAuth
      User? user = FirebaseAuth.instance.currentUser;
      String? userUid = user?.uid;

      if (userUid == null) {
        // Handle the case where the user is not authenticated
        return;
      }

      // Get a reference to the Firestore collection
      CollectionReference jobsCollection =
          FirebaseFirestore.instance.collection('jobs');

      // Generate a unique job ID (e.g., using a timestamp)
      String timestamp = Timestamp.now().millisecondsSinceEpoch.toString();

      // Use the user's UID as the document ID for the main job document
      DocumentReference jobDocument = jobsCollection.doc(userUid);

      // Create or update a subcollection called "jobsnew" under the main job document
      CollectionReference jobsNewCollection = jobDocument.collection('jobsnew');

      // Upload images to Firebase Storage and get download URLs
      String? image1Url =
          await uploadImageToStorage(_selectedImage1, 'image1_$timestamp');
      String? image2Url =
          await uploadImageToStorage(_selectedImage2, 'image2_$timestamp');

      // Add job data to Firestore within the "jobsnew" subcollection
      await jobsNewCollection.doc(timestamp).set({
        'JobID': timestamp,
        'jobTitle': jobTitle,
        'jobDescription': jobDescription,
        'dayCount': dayCount,
        'budget': budget,
        'skills': _skills,
        'image1Url': image1Url,
        'image2Url': image2Url,
        'status': 'new', // Set the status to "active"
        'createdAt': FieldValue.serverTimestamp(), // Add the timestamp field
        // You can add more fields as needed
      });
    } catch (e) {
      // Handle any errors that occur
    }
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final isRecording = recorder.isRecording;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Post a Job',
            style: kHeadingTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 4,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.navigate_before,
              color: kDeepBlueColor,
            ),
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
        ),
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/noise_image.webp'),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 12.0,
                  ),
                  const UserDataGatherTitle(
                    title: 'Job Title',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: UserDataGatherTextField(
                      controller: jobTitleController,
                      hintText: 'Ex: Need a Logo designer',
                      validatorText: 'Field can\'t be empty',
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const UserDataGatherTitle(
                    title: 'Describe about the project',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: jobDescriptionController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Add job description here',
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
                      maxLines: 6,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const UserDataGatherTitle(
                    title: 'Skills',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: skillController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: 'Add Skills',
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
                      maxLines: 2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Service 1 and Service 2 side by side
                      GestureDetector(
                        onTap: () => selectService('Logo Design'),
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
                            'Logo Design',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () => selectService('Illustrator'),
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
                            'Illustrator',
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
                        onTap: () => selectService('Photoshop'),
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
                            'Photoshop',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreyColor,
                            ),
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () => selectService('Print design'),
                      //   child: Container(
                      //     margin: const EdgeInsets.symmetric(horizontal: 0.0),
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 16.0,
                      //         vertical: 8.0), // Adjust the padding
                      //     decoration: BoxDecoration(
                      //       color: Colors.transparent,
                      //       border: Border.all(
                      //         color: kDarkGreyColor,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: const Text(
                      //       'Print design',
                      //       style: TextStyle(
                      //         fontSize: 11,
                      //         fontWeight: FontWeight.bold,
                      //         color: kDarkGreyColor,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const UserDataGatherTitle(
                    title: 'Job done within',
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth / 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            controller: dayCountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              hintText: '1-7 Days',
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
                              return null;
                            },
                          ),
                        ),
                      ),
                      const Text('Days'),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const UserDataGatherTitle(
                    title: 'Budget',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: budgetController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: 'LKR  ',
                        prefixStyle: const TextStyle(
                          color: kDeepBlueColor,
                        ),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: '1000-4500',
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
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const UserDataGatherTitle(
                    title: 'Attachments',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: InkWell(
                            onTap: () {
                              uploadFile(1);
                            },
                            child: AttachmentCard(
                              cardChild: _selectedImage1 != null
                                  ? Image.file(
                                      _selectedImage1!,
                                      fit: BoxFit
                                          .cover, // Adjust the fit as needed
                                    )
                                  : Container(), // Empty container if _selectedImage2 is null
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: () {
                              uploadFile(2);
                            },
                            child: AttachmentCard(
                              cardChild: _selectedImage2 != null
                                  ? Image.file(
                                      _selectedImage2!,
                                      fit: BoxFit
                                          .cover, // Adjust the fit as needed
                                    )
                                  : Container(), // Empty container if _selectedImage2 is null
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const UserDataGatherTitle(
                    title: 'Express your job with Voice',
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        StreamBuilder<RecordingDisposition>(
                            stream: recorder.onProgress,
                            builder: (context, snapshot) {
                              final duration = snapshot.hasData
                                  ? snapshot.data!.duration
                                  : Duration.zero;
                              String twoDigits(int n) =>
                                  n.toString().padLeft(2, '0');
                              final twoDigitMinutes =
                                  twoDigits(duration.inMinutes.remainder(60));
                              final twoDigitSeconds =
                                  twoDigits(duration.inSeconds.remainder(60));

                              return Text(
                                '$twoDigitMinutes:$twoDigitSeconds',
                                style: kHeadingTextStyle,
                              );
                            }),
                        // ElevatedButton.icon(
                        //   onPressed: () async {
                        //     recorder.toggleRecording();
                        //     setState(() {});
                        //   },
                        //   icon:
                        //       isRecording ? Icon(Icons.stop) : Icon(Icons.mic),
                        //   label: isRecording ? Text('Stop') : Text('Record'),
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kDeepBlueColor,
                          ),
                          child: IconButton(
                            tooltip: recorder.isRecording
                                ? 'Tap here to Stop'
                                : 'Tap here to record',
                            onPressed: () async {
                              if (recorder.isRecording) {
                                await stop();
                              } else {
                                await record();
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              recorder.isRecording ? Icons.stop : Icons.mic,
                              color: kBrilliantWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const UserDataGatherTitle(
                    title: 'Play the Recording',
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kDeepBlueColor,
                      ),
                      child: IconButton(
                        // tooltip:
                        //     isPlaying ? 'Tap here to Stop' : 'Tap here to Play',
                        onPressed: () {
                          final audioPlayer = AudioPlayer();
                          audioPlayer.play(
                            AssetSource('voice.mp3'),
                          );
                        },
                        icon: Icon(
                          // isPlaying ? Icons.stop :
                          Icons.play_arrow,
                          color: kBrilliantWhite,
                        ),
                      ),
                    ),
                  ),
                  DarkMainButton(
                    title: 'Post Job Now',
                    process: () {
                      if (formKey.currentState!.validate()) {
                        String jobTitle = jobTitleController.text;
                        String jobDescription = jobDescriptionController.text;
                        int dayCount =
                            int.tryParse(dayCountController.text) ?? 0;
                        int budget = int.tryParse(budgetController.text) ?? 0;
                        addJobToFirestore(
                          jobTitle,
                          jobDescription,
                          dayCount,
                          budget,
                        );
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return MaintenancePage(
                              [
                                const Image(
                                  image: AssetImage('images/tick.webp'),
                                ),
                                Text(
                                  'Posted!',
                                  style: kSubHeadingTextStyle.copyWith(
                                      height: 0.5),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Now keep in touch with your job for bids.',
                                    style: kTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                DarkMainButton(
                                    title: 'Visit Job Status',
                                    process: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => ClientHomePage(
                                              // selectedIndex: 2,
                                              // client: widget.client,
                                              ),
                                        ),
                                      );
                                    },
                                    screenWidth: screenWidth)
                              ],
                            );
                          },
                        );
                      }
                    },
                    screenWidth: screenWidth,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadImageToStorage(File? image, String imageName) async {
    if (image == null) {
      return null;
    }

    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$imageName');
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() async {
        // Wait for the upload to complete and then return the download URL
        return await storageReference.getDownloadURL();
      });

      // If the await inside whenComplete doesn't work as expected,
      // you can try using await for the whole operation
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      // Handle errors
    }

    return null;
  }
}
