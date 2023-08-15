import 'package:flutter/material.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Projects'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Best Match'),
              Tab(text: 'Most Recent'),

            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/noise_image.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: TabBarView(
            children: [
              // Widgets for each tab's content
              Center(child: Text('Tab 1 Content')),
              Center(child: Text('Tab 2 Content')),
              Center(child: Text('Tab 3 Content')),
            ],
          ),
        ),
      ),
    );
  }
}
