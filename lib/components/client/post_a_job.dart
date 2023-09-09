import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/client_post_job.dart';

class PostAJob extends StatelessWidget {
  const PostAJob({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32.0),
      padding: const EdgeInsets.all(8.0),
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 1.0,
          color: kDeepBlueColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Get your work Done',
              style: kJobCardTitleTextStyle.copyWith(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.0),
            child: Text(
              'You haven’t posted any job, Post your job and find the best talented graphic designers in Sri Lanka',
              style: kTextStyle.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          DarkMainButton(
              title: 'Post a Job',
              process: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ClientPostJob(),
                  ),
                );
              },
              screenWidth: screenWidth)
        ],
      ),
    );
  }
}
