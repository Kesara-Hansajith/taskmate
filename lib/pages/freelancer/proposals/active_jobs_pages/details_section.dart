import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/models/active_job_details_data.dart';
import 'package:taskmate/components/attachment_card.dart';

class Details extends StatefulWidget {
  // final String documentID;
  final String jobTitle; // Add this parameter
  final String jobDescription;
  final String budgetField;

  const Details({
    super.key,
    required this.jobTitle,
    required this.jobDescription,
    required this.budgetField,
    // required this.documentID,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Recieved on: 2023.09.01',style: kTextStyle,)],
            ),
            Text(
              'Job Title',
              style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
            ),
            Text(
              widget.jobTitle, // Display the jobTitle from the widget parameter
              style: kTextStyle,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Description',
              style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
            ),
            Text(
              widget.jobDescription,
              style: kTextStyle,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Price',
              style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
            ),
            Text(
              widget.budgetField,
              style: kTextStyle,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Attachments',
              style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: AttachmentCard(
                      cardChild: Text('Tap Here'),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: AttachmentCard(
                      cardChild: Text('Tap Here'),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
