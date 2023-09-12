import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:taskmate/FreelancerDashboard/Dashboard.dart';
import 'package:taskmate/bottom_nav_bar/freelancer/messaging.dart';
import 'package:taskmate/bottom_nav_bar/freelancer/proposals.dart';
import 'package:taskmate/bottom_nav_bar/freelancer/jobs.dart';
import 'package:taskmate/bottom_nav_bar/freelancer/account.dart';
import 'package:taskmate/messaging/Receivemsg.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';

class FreelancerHomePage extends StatefulWidget {
  FreelancerHomePage({super.key, required this.user, this.profileImageUrl});
  final UserModel user;
  String? profileImageUrl;

  @override
  State<FreelancerHomePage> createState() => _FreelancerHomePageState();
}

class _FreelancerHomePageState extends State<FreelancerHomePage> {
  int _selectedIndex = 2;

  late final List _items = [
    Receivemsg(),
    const Proposals(),
    const Jobs(),
    DashboardFreelance(
      user: widget.user,
      profileImageUrl: widget.profileImageUrl,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: GNav(
          gap: 10.0,
          selectedIndex: _selectedIndex,
          onTabChange: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const <GButton>[
            GButton(
              icon: Icons.mail_outline,
              text: 'Messages',
            ),
            GButton(
              icon: Icons.work_history,
              text: 'Job Status',
            ),
            GButton(
              icon: Icons.work,
              text: 'Jobs',
            ),
            GButton(
              icon: Icons.person,
              text: 'Account',
            ),
          ],
        ),
        body: _items[_selectedIndex],
      ),
    );
  }
}
