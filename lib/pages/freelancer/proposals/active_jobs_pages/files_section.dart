import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmate/components/attachment_card.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../../components/snackbar.dart';

class Files extends StatefulWidget {
  const Files({
    super.key,
  });

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  File? _selectedImage1;
  File? _selectedImage2;

  Future<void> _pickImage1() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage1 = File(pickedFile.path); // Store the selected image
      });
    }
  }

  Future<void> _pickImage2() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage2 = File(pickedFile.path); // Store the selected image
      });
    }
  }

  Future<void> _uploadImagesToFirebase() async {
    if (_selectedImage1 != null && _selectedImage2 != null) {
      try {
        final FirebaseStorage storage = FirebaseStorage.instance;

        // Upload the first image
        final Reference ref1 = storage
            .ref()
            .child('files/${path.basename(_selectedImage1!.path)}');
        final UploadTask task1 = ref1.putFile(_selectedImage1!);

        // Upload the second image
        final Reference ref2 = storage
            .ref()
            .child('files/${path.basename(_selectedImage2!.path)}');
        final UploadTask task2 = ref2.putFile(_selectedImage2!);

        // Wait for both uploads to complete
        await Future.wait([
          task1.whenComplete(() => print('Image 1 uploaded')),
          task2.whenComplete(() => print('Image 2 uploaded'))
        ]);

        // After both images are uploaded, you can perform any additional actions you need, such as saving the download URLs.
        // You can get the download URLs using task1.snapshot.ref.getDownloadURL() and task2.snapshot.ref.getDownloadURL().

        // TODO: Add your additional logic here
      } catch (e) {
        print('Error uploading images: $e');
        // Handle errors here
      }
    } else {
      // Handle case when one or both images are not selected
      print('Please select both images before submitting.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Submit work for get the payment',
              style: kJobCardTitleTextStyle.copyWith(
                color: kJetBlack,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage1(); // Call the _pickImage function when tapped
                        },
                        child: AttachmentCard(
                          cardChild: _selectedImage1 == null
                              ? const Text('+ Add')
                              : Image.file(_selectedImage1!),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _selectedImage1 = null; // Reset selected image
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(
                              Icons.delete,
                              color: kDarkGreyColor,
                            ),
                            Text(
                              'Delete',
                              style: kTextStyle,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage2(); // Call the _pickImage function when tapped
                        },
                        child: AttachmentCard(
                          cardChild: _selectedImage2 == null
                              ? const Text('+ Add')
                              : Image.file(_selectedImage2!),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _selectedImage2 = null; // Reset selected image
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(
                              Icons.delete,
                              color: kDarkGreyColor,
                            ),
                            Text(
                              'Delete',
                              style: kTextStyle,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            DarkMainButton(
              title: 'Submit Work',
              process: () {
                if (_selectedImage1 == null || _selectedImage2 == null) {
                  // Show the snackbar with the error message
                  ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar('Please select both images'));
                } else {
                  _uploadImagesToFirebase();
                }
              },
              screenWidth: screenWidth,
            ),
            LightMainButton(
                title: 'Message',
                process: () {
                  //TODO Forward to messaging part
                },
                screenWidth: screenWidth)
          ],
        ),
      ),
    );
  }
}
