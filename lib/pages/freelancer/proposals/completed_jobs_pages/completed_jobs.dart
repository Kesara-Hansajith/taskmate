import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/constants.dart';

import 'completed_job_card.dart';


class CompletedJobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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

              return ListView.builder(
                itemCount: jobDocs.length,
                itemBuilder: (context, index) {
                  final doc = jobDocs[index];
                  return StreamBuilder<QuerySnapshot>(
                    stream: doc.reference
                        .collection('jobsnew')
                        .where('status', isEqualTo: 'complete') // Filter active jobs
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
                          child: Text('No completed jobs found'),
                        );
                      }

                      final completeJobDoc = subSnapshot.data!.docs;
                      final data = doc.data() as Map<String, dynamic>;

                      return Column(
                        children: completeJobDoc.map<Widget>((subDoc) {
                          return CompletedJobCard(completeJobDoc: subDoc);
                        }).toList(),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}