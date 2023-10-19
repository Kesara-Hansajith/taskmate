import 'package:flutter/material.dart';
import 'package:taskmate/components/client/post_a_job.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/profile/client/user_model1.dart';

class ClientPosted extends StatefulWidget {
  const ClientPosted({
    super.key,
     required this.client,
  });

   final UserModel1 client; // Add this line

  @override
  State<ClientPosted> createState() => _ClientPostedState();
}

class _ClientPostedState extends State<ClientPosted> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 60.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome Back, ',
                      style: kJobCardTitleTextStyle,
                    ),
                    Text(
                      '${widget.client.firstName} ${widget.client.lastName}',
                      style: kSubHeadingTextStyle,
                    ),
                    PostAJob(
                         client: widget.client,
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
