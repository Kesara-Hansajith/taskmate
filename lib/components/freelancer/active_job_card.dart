import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';

class ActiveJobCard extends StatefulWidget {
  const ActiveJobCard({super.key});

  @override
  State<ActiveJobCard> createState() => _ActiveJobCardState();
}

class _ActiveJobCardState extends State<ActiveJobCard> {
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
          Text('Graphic designer for family care product',
              style: kJobCardTitleTextStyle),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
