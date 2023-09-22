import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/pending/bidded_freelancers.dart';
// import 'package:taskmate/pages/client/jobs/pending/client_pending_job_details.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/active_job_details.dart';

class ClientPendingJobCard extends StatefulWidget {
  const ClientPendingJobCard(
      {
      // required this.documentID,
      // required this.data,
      super.key});

  // final String documentID;
  // final Map<String, dynamic> data;

  @override
  State<ClientPendingJobCard> createState() => _ClientPendingJobCardState();
}

class _ClientPendingJobCardState extends State<ClientPendingJobCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Check if widget.data is not null and is of type Map<String, dynamic>
    // if (widget.data != null && widget.data is Map<String, dynamic>) {
    //   final data = widget.data as Map<String, dynamic>;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BiddedFreelancers(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: kDeepBlueColor, width: 1.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    'Title',
                    style: kJobCardTitleTextStyle,
                  ),
                ),
                Text(
                  'Budget Range: LKR.3000 - 5000',
                  style: kJobCardDescriptionTextStyle,
                ),
                Text(
                  'Posted on: ',
                  style: kJobCardDescriptionTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    'Proposals: 03',
                    style: kJobCardDescriptionTextStyle.copyWith(
                        fontWeight: FontWeight.bold, color: kDeepBlueColor),
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.navigate_next,
              size: 35.0,
            ),
          ],
        ),
      ),
    );

  }
}
