import 'package:flutter/material.dart';
import 'package:taskmate/bottom_nav_bar/client/client_account.dart';
// import 'package:taskmate/client_dashboard/Dashboard.dart';
import 'package:taskmate/bottom_nav_bar/client/client_job_status.dart';
import 'package:taskmate/bottom_nav_bar/client/client_messaging.dart';
import 'package:taskmate/bottom_nav_bar/client/client_posted.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:taskmate/dashboard/client/dashboard.dart';
import 'package:taskmate/profile/client/user_model1.dart';

class ClientHomePage extends StatefulWidget {
  ClientHomePage({
     required this.client,
    // required this.selectedIndex,
     this.downloadUrl,
    super.key,
  });

   final UserModel1 client; // Add this line
   final String? downloadUrl;


  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int selectedIndex=0;
  late final List _items = [
    const ClientMessaging(),
    ClientPosted(
       client: widget.client,
    ),
    const ClientJobStatus(),
    Dashboard(
       client: widget.client,
      downloadUrl: widget.downloadUrl,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: GNav(
          gap: 10.0,
          selectedIndex: selectedIndex,
          onTabChange: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.mail_outline,
              text: 'Messages',
            ),
            GButton(
              icon: Icons.add_circle,
              text: 'Post a Job',
            ),
            GButton(
              icon: Icons.work,
              text: 'Job Status',
            ),
            GButton(
              icon: Icons.person,
              text: 'Account',
            ),
          ],
        ),
        body: _items[selectedIndex],
      ),
    );
  }
}
