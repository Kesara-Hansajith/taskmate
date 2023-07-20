import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskmate/job_details.dart';

class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  DocumentReference userDocRef = FirebaseFirestore.instance
      .collection('projects')
      .doc('q8hn2GdtWkORz2PFK7fm');

  String? title = 'Fetching User Data...';
  String? username = 'Fetching User Data...';
  String? price = 'Fetching User Data...';
  String? duration = 'Fetching User Data...';

  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    getProject();
  }

  Future<void> getProject() async {
    try {
      DocumentSnapshot documentSnapshot = await userDocRef.get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            title = data['title'];
            username = data['username'];
            //postedOn = data['posted_on'];
            price = data['price'].toString();
            duration = data['duration'].toString();
          });
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kDeepBlueColor,
          title: const Text('Jobs'),
          bottom: const TabBar(
            indicatorColor: kBrilliantWhite,
            tabs: <Widget>[
              Tab(
                icon: Text('Best Match'),
              ),
              Tab(
                icon: Text('Most Recent'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //Best Match Jobs goes here
            ListView(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JobDetails(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: kOceanBlueColor, width: 3.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '$title',
                          style: const TextStyle(fontSize: 22),
                        ),
                        Row(
                          children: <Widget>[
                            const Text('Posted by : '),
                            Text('$username'),
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
                              Text('$price'),
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
                              Text('$duration'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //Most Recent Jobs goes here
            ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: kOceanBlueColor, width: 3.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Most Recent Job',
                        style: TextStyle(fontSize: 22),
                      ),
                      Row(
                        children: const <Widget>[
                          Text('Posted by : '),
                          Text('GoviKamburugamuwa'),
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
                          ],
                        ),
                      ),
                      //Price goes here
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Icon(Icons.attach_money),
                            Text('  Price : '),
                          ],
                        ),
                      ),
                      //Duration goes here
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Icon(Icons.timelapse),
                            Text('  Duration : '),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
