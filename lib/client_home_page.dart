import 'package:flutter/material.dart';
import 'package:taskmate/bottom_nav_bar/client/client_account.dart';
import 'package:taskmate/bottom_nav_bar/client/client_messaging.dart';
import 'package:taskmate/bottom_nav_bar/client/client_posted.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int _selectedIndex = 1;

  final List _items = [
    const ClientMessaging(),
    const ClientPosted(),
    const ClientAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        gap: 10.0,
        selectedIndex: _selectedIndex,
        onTabChange: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        tabs: const [
          GButton(
            icon: Icons.mail_outline,
            text: 'Messages',
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
    );
  }
}
