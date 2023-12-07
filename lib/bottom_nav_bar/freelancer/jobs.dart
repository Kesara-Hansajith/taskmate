import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/freelancer/job_details.dart';

import '../../components/job_card.dart';

class Jobs extends StatefulWidget {
  const Jobs({Key? key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Projects',
              style: kHeadingTextStyle,
            ),
          ),
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'images/noise_image.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: kDeepBlueColor,
            unselectedLabelColor: kDarkGreyColor,
            labelStyle: TextStyle(
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
            indicatorColor: kDeepBlueColor,
            tabs: [
              Tab(text: 'Best Match'),
              Tab(text: 'Most Recent'),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              // StreamBuilder for "Best Match" tab
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('jobs').snapshots(),
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
                            .where('status',
                                isEqualTo: 'new') // Change filter condition
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
                            // return const Center(
                            //   child: Text('No matching jobs found'),
                            // );
                          }

                          final matchingJobDocs = subSnapshot.data!.docs;

                          // Create a Set to keep track of unique job IDs
                          final Set<String> uniqueJobIds = Set();

                          // Filter out duplicate jobs
                          final filteredJobDocs =
                              matchingJobDocs.where((subDoc) {
                            final jobId = subDoc.id;
                            if (uniqueJobIds.contains(jobId)) {
                              return false; // Skip duplicate job
                            } else {
                              uniqueJobIds.add(jobId);
                              return true; // Include unique job
                            }
                          }).toList();

                          // Customize how you want to display each matching job in the list
                          return Column(
                            children: filteredJobDocs.map<Widget>((subDoc) {
                              return JobCard(
                                  mostjobDoc: subDoc, screenWidth: screenWidth);
                            }).toList(),
                          );
                        },
                      );
                    },
                  );
                },
              ),

              // StreamBuilder for "Most Recent" tab
              const Center(
                child: Text('Most Recent Jobs will be displayed here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
