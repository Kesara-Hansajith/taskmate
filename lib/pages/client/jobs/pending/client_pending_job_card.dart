import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
// import 'package:taskmate/pages/client/jobs/pending/client_pending_job_details.dart';
import 'package:taskmate/pages/freelancer/proposals/active_jobs_pages/active_job_details.dart';

class ClientPendingJobCard extends StatefulWidget {
  const ClientPendingJobCard({
    required this.documentID,
    required this.data,
  });

  final String documentID;
  final Map<String, dynamic> data;

  @override
  State<ClientPendingJobCard> createState() => _ClientPendingJobCardState();
}

class _ClientPendingJobCardState extends State<ClientPendingJobCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Check if widget.data is not null and is of type Map<String, dynamic>
    if (widget.data != null && widget.data is Map<String, dynamic>) {
      final data = widget.data as Map<String, dynamic>;
      return InkWell(
        onTap: () {
          // Handle onTap action if needed
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
          width: screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: kDeepBlueColor, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${data['jobTitle']}',
                style: kJobCardTitleTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price Range: LKR.${data['budget']}',
                      style: kJobCardDescriptionTextStyle,
                    ),
                    Text(
                      'Job Done within: ${data['dayCount']}',
                      style: kJobCardDescriptionTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Handle the case when data is null or not of the expected type
      return const Center(
        child: Text('Data not available'),
      );
    }
  }
}
