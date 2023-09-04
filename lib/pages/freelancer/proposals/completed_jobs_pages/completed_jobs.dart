import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/components/freelancer/completed_job_card.dart';

class CompletedJobs extends StatefulWidget {
  const CompletedJobs({super.key});

  @override
  State<CompletedJobs> createState() => _CompletedJobsState();
}

class _CompletedJobsState extends State<CompletedJobs> {
  List<String> _docIDs = [];

  //Getting docIDs
  Future<void> getDocIDs() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('completed_jobs').get();
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
                    return CompletedJobCard(
                      documentID: _docIDs[index].toString(),
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
