import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:taskmate/constants.dart';
import 'package:taskmate/job_details.dart';

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
              StreamBuilder<QuerySnapshot>(
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
                        stream: doc.reference.collection('jobsnew').where('status', isEqualTo: 'pending').snapshots(),
                        builder: (context, subSnapshot) {
                          if (subSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!subSnapshot.hasData || subSnapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('No pending jobs found'),
                            );
                          }

                          final jobNewDocs = subSnapshot.data!.docs;
                          final data = doc.data() as Map<String, dynamic>;

                          return JobCard(
                            documentID: doc.id,
                            screenWidth: screenWidth,
                            jobData: data,
                            jobNewDocs: jobNewDocs,
                          );
                        },
                      );
                    },
                  );
                },
              ),

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
