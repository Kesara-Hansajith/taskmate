import 'package:flutter/material.dart';
import 'package:taskmate/components/client/post_a_job.dart';
import 'package:taskmate/constants.dart';

class ClientPosted extends StatefulWidget {
  const ClientPosted({super.key});

  @override
  State<ClientPosted> createState() => _ClientPostedState();
}

class _ClientPostedState extends State<ClientPosted> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 60.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Welcome Back, ',
                        style: kJobCardTitleTextStyle,
                      ),
                      Text(
                        'Nimali Ihalagama ',
                        style: kSubHeadingTextStyle,
                      ),
                      PostAJob(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
