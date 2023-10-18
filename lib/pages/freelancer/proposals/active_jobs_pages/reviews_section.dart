import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/snackbar.dart';
import 'package:taskmate/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Reviews extends StatefulWidget {
  final QueryDocumentSnapshot activeJobDoc;

  const Reviews({
    required this.activeJobDoc,
    Key? key,
  }) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final _formKey = GlobalKey<FormState>();
  int _starRating = 0;

  TextEditingController reviewFieldController = TextEditingController();

  // Function to submit the review
  void submitReview() async {
    if (_formKey.currentState!.validate() && _starRating != 0) {
      // Firestore collection reference
      final DocumentReference docRef =
          widget.activeJobDoc.reference; // Access from widget properties

      // Update the Firestore document for the review
      await docRef.update({
        'reviewdesfreelancer': reviewFieldController.text,
        'starfreelancer': _starRating,
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar('Review submitted successfully.'),
      );
    } else {
      // Show an error message if the form is not valid or no star rating
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          'Please provide a review and rate the user with stars.',
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Write Your Review',
              style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: reviewFieldController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Write a review about your Client.',
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
                      width: 1.0,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'Rate with Stars!',
                style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _starRating = rating.toInt();
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      (_starRating == 1
                          ? 'You offered $_starRating Star!'
                          : 'You offered $_starRating Stars!'),
                      style: kJobCardTitleTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            DarkMainButton(
              title: 'Submit Review',
              process: submitReview, // Use the submitReview function
              screenWidth: screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}
