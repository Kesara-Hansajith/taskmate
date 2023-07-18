import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                      Text(
                        'Best Match Job',
                        style: TextStyle(fontSize: 22),
                      ),
                      Row(
                        children: <Widget>[
                          const Text('Posted by : '),
                          const Text('GoviKamburugamuwa'),
                        ],
                      ),
                      //Post Date goes here
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(Icons.schedule),
                            const Text('  Posted on : '),
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
                          children: <Widget>[
                            const Icon(Icons.timelapse),
                            const Text('  Duration : '),
                          ],
                        ),
                      ),
                      //See Job Details button goes here
                      Container(
                        margin: EdgeInsets.all(8.0),
                        width: screenWidth,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                kDeepBlueColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text('See Job Details'),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
                      Text(
                        'Most Recent Job',
                        style: TextStyle(fontSize: 22),
                      ),
                      Row(
                        children: <Widget>[
                          const Text('Posted by : '),
                          const Text('GoviKamburugamuwa'),
                        ],
                      ),
                      //Post Date goes here
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(Icons.schedule),
                            const Text('  Posted on : '),
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
                          children: <Widget>[
                            const Icon(Icons.timelapse),
                            const Text('  Duration : '),
                          ],
                        ),
                      ),
                      //See Job Details button goes here
                      Container(
                        margin: EdgeInsets.all(8.0),
                        width: screenWidth,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                kDeepBlueColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text('See Job Details'),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
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
