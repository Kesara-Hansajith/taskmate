import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:taskmate/pages/client/jobs/pending/client_pending_job_card.dart';

class ClientPendingJobs extends StatefulWidget {
  const ClientPendingJobs({super.key});

  @override
  State<ClientPendingJobs> createState() => _ClientPendingJobsState();
}

class _ClientPendingJobsState extends State<ClientPendingJobs> {
  List<String> _docIDs = [];

  //Getting docIDs
  Future<void> getDocIDs() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('client_pending_jobs')
        .get();
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
            child: StreamBuilder(
              //future: getDocIDs(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: _docIDs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: ClientPendingJobCard(
                        documentID: _docIDs[index].toString(),
                      ),
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
