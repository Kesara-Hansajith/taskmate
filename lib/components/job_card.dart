import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/job_details.dart';

class JobCard extends StatefulWidget {
  // const JobCard({
  //   super.key,

  //   required this.title,
  //   required this.username,
  //   required this.price,
  //   required this.duration,
  // });

  const JobCard(
      {super.key, required this.documentID, required this.screenWidth});

  final double screenWidth;
  // final String? title;
  // final String? username;
  // final String? price;
  // final String? duration;
  final String? documentID;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    CollectionReference projects =
        FirebaseFirestore.instance.collection('available_projects');

    return FutureBuilder<DocumentSnapshot>(
        future: projects.doc(widget.documentID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            //Overall Job Card flows through here
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => JobDetails(
                    documentID: widget.documentID,
                  ),
                ));
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                width: widget.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: kOceanBlueColor, width: 3.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${data['title']}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Posted by : '),
                        Text('${data['username']}'),
                      ],
                    ),
//Post Date goes here
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(Icons.schedule),
                          Text('  Posted on : '),
// Text('$postedOn'),
                        ],
                      ),
                    ),
//Price goes here
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.attach_money),
                          const Text('  Price : '),
                          Text('${data['price']}'),
                          const Text(' LKR'),
                        ],
                      ),
                    ),
//Duration goes here
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.timelapse),
                          const Text('  Duration : '),
                          Text('${data['duration']}'),
                          const Text(' Days'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Text('Loading....');
        });
  }
}
