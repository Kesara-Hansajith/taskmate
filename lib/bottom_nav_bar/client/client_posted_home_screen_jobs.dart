import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class ClientPostedHomeScreenJobs extends StatefulWidget {
  const ClientPostedHomeScreenJobs({super.key});

  @override
  State<ClientPostedHomeScreenJobs> createState() =>
      _ClientPostedHomeScreenJobsState();
}

class _ClientPostedHomeScreenJobsState
    extends State<ClientPostedHomeScreenJobs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20.0,),
        Text('Your Postings'),
        const Divider(color: kDarkGreyColor,thickness: 0.8,),
      ],
    );
  }
}
