import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/job_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskmate/job_details.dart';

class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  List<String> docIDs = [];

  //Getting docIDs
  Future<void> getDocIDs() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('available_projects').get();
    docIDs = snapshot.docs.map((element) => element.reference.id).toList();
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
    final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      //initialIndex: 0,
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
            FutureBuilder(
                // future: getDocIDs(),
                builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: JobCard(
                          documentID: docIDs[index].toString(),
                          screenWidth: screenWidth),
                    );
                  });
            }),
            //Most Recent Jobs goes here
            // ListView(
            //   children: <Widget>[
            //     Container(
            //       margin: const EdgeInsets.symmetric(
            //           vertical: 16.0, horizontal: 8.0),
            //       padding: const EdgeInsets.symmetric(
            //           vertical: 16.0, horizontal: 8.0),
            //       width: screenWidth,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8.0),
            //         border: Border.all(color: kOceanBlueColor, width: 3.0),
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           const Text(
            //             'Most Recent Job',
            //             style: TextStyle(fontSize: 22),
            //           ),
            //           Row(
            //             children: const <Widget>[
            //               Text('Posted by : '),
            //               Text('GoviKamburugamuwa'),
            //             ],
            //           ),
            //           //Post Date goes here
            //           Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 4.0, horizontal: 16.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: const <Widget>[
            //                 Icon(Icons.schedule),
            //                 Text('  Posted on : '),
            //               ],
            //             ),
            //           ),
            //           //Price goes here
            //           Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 4.0, horizontal: 16.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: const <Widget>[
            //                 Icon(Icons.attach_money),
            //                 Text('  Price : '),
            //               ],
            //             ),
            //           ),
            //           //Duration goes here
            //           Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 4.0, horizontal: 16.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: const <Widget>[
            //                 Icon(Icons.timelapse),
            //                 Text('  Duration : '),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
