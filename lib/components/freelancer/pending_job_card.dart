import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';

class PendingJobCard extends StatefulWidget {
  const PendingJobCard({super.key});

  @override
  State<PendingJobCard> createState() => _PendingJobCardState();
}

class _PendingJobCardState extends State<PendingJobCard> {
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
          const Text('In Progress',
              style: kTextStyle),
          const Text('To Draft a ring for an emerald stone',
              style: kJobCardTitleTextStyle),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Bid Price: LKR. 1500.00',
                  style: kJobCardDescriptionTextStyle,
                ),
                Text(
                  'Total Bids goes here',
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
