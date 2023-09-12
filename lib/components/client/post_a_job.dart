import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/client_post_job.dart';
import 'package:taskmate/profile/client/user_model1.dart';

class PostAJob extends StatefulWidget {
  const PostAJob({
    required this.client,
    super.key,
  });

  final UserModel1 client;

  @override
  State<PostAJob> createState() => _PostAJobState();
}

class _PostAJobState extends State<PostAJob> {
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
              'Get your work Done!',
              style: kJobCardTitleTextStyle.copyWith(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.0),
            child: Text(
              'Publishing a job on our platform is not just a task, it\'s an opportunity to connect with the best freelancers in the industry. We\'ve made it easier and friendlier than ever.',
              style: kTextStyle.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          DarkMainButton(
              title: 'Post a Job',
              process: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  ClientPostJob(client: widget.client,),
                  ),
                );
              },
              screenWidth: screenWidth)
        ],
      ),
    );
  }
}
