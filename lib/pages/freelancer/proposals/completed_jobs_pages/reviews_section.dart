import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Reviews extends StatefulWidget {
  final QueryDocumentSnapshot completeJobDoc;

  const Reviews({
    Key? key,
    required this.completeJobDoc,
  }) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  late double clientRating;

  @override
  void initState() {
    super.initState();
    // Initialize clientRating with the actual rating value from Firestore
    clientRating = widget.completeJobDoc['starfreelancer']?.toDouble() ?? 0.0;
    clientRating = clientRating.roundToDouble(); // Round to the nearest integer
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Extract review data from the document snapshot
    String clientReview = widget.completeJobDoc['reviewdesfreelancer'] ?? '';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Review from @ClientName',
                    style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
                  ),
                ),
                Text(
                  'Kesara was great on the project, delivered what I wanted quickly. Recommend!',
                  style: kTextStyle,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Divider(
                  thickness: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text(
                    'Your Review',
                    style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
                  ),
                ),
                Text(
                  clientReview,
                  style: kTextStyle,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                // Display colored stars based on the actual rating value
                RatingBar.builder(
                  initialRating: clientRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5, // Fixed total number of stars
                  itemSize: 30.0,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.star,
                      color: index < clientRating ? Colors.amber : Colors.grey, // Color based on the rating
                    );
                  },
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
