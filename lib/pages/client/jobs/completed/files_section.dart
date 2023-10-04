import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/components/attachment_card.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:dotted_border/dotted_border.dart';

class Files extends StatefulWidget {
  final String image3Url;
  final String image4Url;
  final QueryDocumentSnapshot completeJobDoc;

  const Files({
    super.key,
    required this.image3Url,
    required this.image4Url,
    required this.completeJobDoc,
  }) ;

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  late final String imageUrl3;
  late final String imageUrl4;

  @override
  void initState() {
    super.initState();
    imageUrl3 = widget.completeJobDoc['image3Url'];
    imageUrl4 = widget.completeJobDoc['image4Url'];
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
              'Submitted Submissions',
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
                        },
                        child: AttachmentCard(
                          cardChild: Image.network(imageUrl3),
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
                        },
                        child: AttachmentCard(
                          cardChild: Image.network(imageUrl4),
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

          ],
        ),
      ),
    );
  }
}
