import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/constants.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final reviewFieldController = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              'Write Your Review',
              style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
          ),
          const SizedBox(
            height: 50.0,
          ),
          DarkMainButton(
              title: 'Submit Review',
              process: () {
                if (_formKey.currentState!.validate()) {}
                //TODO Submit review functionality
              },
              screenWidth: screenWidth)
        ],
      ),
    );
  }
}
