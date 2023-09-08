import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/authentication/create_my_account_1.dart';

import '../ClientDashboard/Dashboard.dart';
import '../profile/freelancer/user_model.dart';
import 'Dashboard.dart';

class TermsandConditionsFreelancer extends StatefulWidget {
  final UserModel user;
  final String? profileImageUrl;

  const TermsandConditionsFreelancer ({required this.user, this.profileImageUrl});

  @override
  State<TermsandConditionsFreelancer> createState() => _TermsandConditionsFreelancerState();
}

class _TermsandConditionsFreelancerState extends State<TermsandConditionsFreelancer> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/noise_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 0, right: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>  DashboardFreelance(user: widget.user,profileImageUrl: widget.profileImageUrl,),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp,size: 30.0),
                      color: kDeepBlueColor,

                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontSize: 35, // Adjust the font size as needed
                          fontWeight: FontWeight.w600,
                          color: kDeepBlueColor, // Adjust the text color as needed
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
    );
  }
}

