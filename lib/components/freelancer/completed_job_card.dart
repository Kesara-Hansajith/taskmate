import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';

class CompletedJobCard extends StatefulWidget {
  const CompletedJobCard({super.key});

  @override
  State<CompletedJobCard> createState() => _CompletedJobCardState();
}

class _CompletedJobCardState extends State<CompletedJobCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: kDeepBlueColor, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Completed',
            style: kTextStyle,
          ),
          const Text('Logo for IT Consulting Firm',
              style: kJobCardTitleTextStyle),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '@kesara_00',
                  style: kJobCardDescriptionTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
