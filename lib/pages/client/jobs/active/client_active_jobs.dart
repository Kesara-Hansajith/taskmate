import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'client_active_job_card.dart';

class ClientActiveJobs extends StatefulWidget {
  const ClientActiveJobs({Key? key}) : super(key: key);

  @override
  State<ClientActiveJobs> createState() => _ClientActiveJobsState();
}

class _ClientActiveJobsState extends State<ClientActiveJobs> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Get the current user's UID
    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: SizedBox(
          width: screenWidth,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No documents found.'),
                );
              }

              final jobDocs = snapshot.data!.docs;

              return Column(
                children: jobDocs.map<Widget>((doc) {
                  // Check if the job belongs to the current user
                  if (doc.id == userUid) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: doc.reference
                          .collection('jobsnew')
                          .where('status', isEqualTo: 'active')
                          .snapshots(),
                      builder: (context, subSnapshot) {
                        if (subSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!subSnapshot.hasData ||
                            subSnapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('No active jobs found'),
                          );
                        }

                        final activeJobDocs = subSnapshot.data!.docs;

                        return Column(
                          children: activeJobDocs.map<Widget>((subDoc) {
                            return ClientActiveJobCard(activeJobDoc: subDoc);
                          }).toList(),
                        );
                      },
                    );
                  } else {
                    return Container(); // If the job doesn't belong to the current user
                  }
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
