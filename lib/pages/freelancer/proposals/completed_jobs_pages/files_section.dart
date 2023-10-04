import 'package:cloud_firestore/cloud_firestore.dart';
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
  final QueryDocumentSnapshot completeJobDoc;

  const Files({
    Key? key,
    required this.completeJobDoc,
  }) : super(key: key);

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {

/// Custom method to display an image in full-screen with a black background
  void _showFullScreenImage(String imageUrl) {
    if (imageUrl != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Container(
            color: Colors.black, // Set background color to black
            child: Center(
              child: Image.network(imageUrl),
            ),
          ),
        ),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final imageUrl3 = widget.completeJobDoc['image3Url'];
    final imageUrl4 = widget.completeJobDoc['image4Url'];

    return SingleChildScrollView(
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Submitted work',
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
                          _showFullScreenImage(imageUrl3); // Call the _pickImage function when tapped
                        },
                        child: imageUrl3 != null
                            ? Image.network(imageUrl3)
                            : const Text('Tap Here'),
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
                          _showFullScreenImage(imageUrl4);
                        },
                        child: imageUrl4 != null
                            ? Image.network(imageUrl4)
                            : const Text('Tap Here'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
