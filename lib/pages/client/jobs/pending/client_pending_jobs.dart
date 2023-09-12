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

  // Getting docIDs
  Future<void> getDocIDs() async {
    final snapshot = await FirebaseFirestore.instance.collection('jobs').get();
    if (snapshot.docs.isNotEmpty) {
      // Check if the query returned any documents
      _docIDs = snapshot.docs.map((element) => element.id).toList();
    }
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
              builder: (context, snapshot) {
                if (_docIDs.isEmpty) {
                  return const Center(
                    child: Text('No documents found.'),
                  );
                }
                return ListView.builder(
                  itemCount: _docIDs.length,
                  itemBuilder: (context, index) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('jobs')
                          .doc(_docIDs[index])
                          .collection('jobsnew') // Access the 'jobsnew' subcollection
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: Text('Loading....'),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error loading data'),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('No documents found.'),
                          );
                        }
                        // Map each document to a ListTile
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, docIndex) {
                            final doc = snapshot.data!.docs[docIndex];
                            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
                            if (data != null) {
                              return ListTile(
                                title: ClientPendingJobCard(
                                  documentID: doc.id,
                                  data: data,
                                ),
                              );
                            } else {
                              return const Center(
                                child: Text('Data not available'),
                              );
                            }
                          },
                        );
                      },
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
