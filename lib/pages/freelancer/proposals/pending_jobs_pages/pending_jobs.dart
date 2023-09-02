import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/components/freelancer/active_job_card.dart';
import 'package:taskmate/components/freelancer/pending_job_card.dart';

class PendingJobs extends StatefulWidget {
  const PendingJobs({super.key});

  @override
  State<PendingJobs> createState() => _PendingJobsState();
}

class _PendingJobsState extends State<PendingJobs> {
  List<String> _docIDs = [];

  //Getting docIDs
  Future<void> getDocIDs() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('pending_jobs').get();
    _docIDs = snapshot.docs.map((element) => element.reference.id).toList();
  }

  @override
  void initState() {
    super.initState();
    // Use a Future inside initState to fetch data asynchronously
    // and use then to handle the result
    getDocIDs().then((_) {
      // Calling setState to rebuild the widget with the fetched data
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              // future: getDocIDs(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: _docIDs.length,
                  itemBuilder: (context, index) {
                    return PendingJobCard(
                      documentID: _docIDs[index].toString(),
                      screenWidth: screenWidth,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
