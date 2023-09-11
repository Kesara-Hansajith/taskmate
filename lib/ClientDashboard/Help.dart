import 'package:flutter/material.dart';
import 'package:taskmate/ClientDashboard/Dashboard.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/authentication/create_my_account_1.dart';

import '../profile/client/user_model1.dart';

class HelpClient extends StatefulWidget {
  final UserModel1 client;
  final String? profileImageUrl;
  
  const HelpClient({required this.client, this.profileImageUrl}) ;

  @override
  State<HelpClient> createState() => _HelpClientState();
}

class _HelpClientState extends State<HelpClient> {
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
                padding: EdgeInsets.only(top: 10, left: 10, right: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => DashboardClient(client: widget.client,profileImageUrl: widget.profileImageUrl,),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp, size: 30.0),
                      color: kDeepBlueColor,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Help & Support',
                        style: TextStyle(
                          fontSize: 38, // Adjust the font size as needed
                          fontWeight: FontWeight.w600,
                          color:
                              kDeepBlueColor, // Adjust the text color as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60, left: 50, right: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'For any kind of help and support please write us on the below mentioned mail ID.Thank you!',
                    style: TextStyle(
                      fontSize: 20, // Adjust the font size as needed
                      fontWeight: FontWeight.w200,
                      color: Colors.grey, // Adjust the text color as needed
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 60, right: 30),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'helpme@taskmate.com',
                    style: TextStyle(
                      color: kDeepBlueColor,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
