import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/dashboard_item.dart';
import 'package:taskmate/dashboard/client/about_us.dart';
import 'package:taskmate/dashboard/client/balance.dart';
import 'package:taskmate/dashboard/client/help_support.dart';
import 'package:taskmate/dashboard/client/invite_friends.dart';
import 'package:taskmate/dashboard/client/profile.dart';
import 'package:taskmate/dashboard/client/terms_conditions.dart';
import 'package:taskmate/dashboard/client/transaction_history.dart';

import '../../profile/client/user_model1.dart';

class Dashboard extends StatefulWidget {
  final UserModel1 client; // Add this line
  final String? downloadUrl;

  const Dashboard({
    required this.client,
    this.downloadUrl,
    super.key
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void navigateToProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Profile(
            client: widget.client
        ),
      ),
    );
  }

  void navigateToBalance() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  Balance(),
      ),
    );
  }

  void navigateToTransactionHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  TransactionHistory(),
      ),
    );
  }

  void navigateToHelpSupport() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  HelpSupport(),
      ),
    );
  }

  void navigateToInviteFriends() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  InviteFriends(),
      ),
    );
  }

  void navigateToTermsConditions() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  TermsConditions(),
      ),
    );
  }

  void navigateToAboutUs() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  AboutUs(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'images/noise_image.webp',
              ),
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: <Container>[
                      Container(
                        width: screenWidth,
                        height: screenHeight / 5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'images/cover_photo.webp',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth,
                        height: screenHeight / 30,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 5.0, // Set the border width
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: widget.client.profilePhotoUrl != null
                          ? AssetImage(widget.client.profilePhotoUrl!)
                          : null, // set to null if profilePhotoUrl is null
                      radius: 40,
                    ),

                  ),
                ],
              ),
              Column(
                children: <Text>[
                  Text(
                    'Good Morning!',
                    style: kJobCardTitleTextStyle.copyWith(color: kAmberColor),
                  ),
                  Text(
                    '${widget.client.firstName} ${widget.client.lastName}',
                    style: kSubHeadingTextStyle,
                  ),

                ],
              ),
              DashboardItem(
                title: 'Profile',
                icon: Icons.badge,
                function: navigateToProfile,
              ),
              DashboardItem(
                title: 'Balance',
                icon: Icons.account_balance,
                function: navigateToBalance,
              ),
              DashboardItem(
                title: 'Trancaction History',
                icon: Icons.currency_exchange,
                function: navigateToTransactionHistory,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                width: screenWidth / 1.2,
                child: const Divider(
                  color: kDarkGreyColor,
                  thickness: 1.0,
                ),
              ),
              DashboardItem(
                title: 'Help & Support',
                icon: Icons.help,
                function: navigateToHelpSupport,
              ),
              DashboardItem(
                title: 'Invite Friends',
                icon: Icons.group_add,
                function: navigateToInviteFriends,
              ),
              DashboardItem(
                title: 'Terms & Conditions',
                icon: Icons.handshake,
                function: navigateToTermsConditions,
              ),
              DashboardItem(
                title: 'About Us',
                icon: Icons.groups,
                function: navigateToAboutUs,
              ),
              TextButton(
                onPressed: () {
                  //TODO Implement streams and sign out process
                },
                child: Text(
                  'Logout',
                  style: kJobCardTitleTextStyle.copyWith(
                    color: kAmberColor,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'TaskMate v1.0',
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //TODO AI Chatbot
          },
          backgroundColor: kDeepBlueColor,
          child: const Icon(Icons.help),
        ),
      ),
    );
  }
}
