import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.imagePath,
    required this.jobTitle,
    required this.feedback,
    required this.username,
  });

  final String imagePath;
  final String jobTitle;
  final String feedback;
  final String username;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: kBrilliantWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 5, // Spread radius
            blurRadius: 7, // Blur radius
            offset: Offset(0, 3), // Offset in the x and y directions
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imagePath),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: kJobCardTitleTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    feedback,
                    style: kTextStyle,
                  ),
                ),
                Text(
                  'by $username',
                  style: kUserDataGatherTitleTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
