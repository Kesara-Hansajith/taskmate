import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/profile/client/EditClientProfile.dart';
import 'package:taskmate/profile/client/user_model1.dart';
import 'package:taskmate/profile/freelancer/EditFreelancerProfile.dart';
import 'package:taskmate/constants.dart';


class DataDetailsScreenClient extends StatefulWidget {
  late final UserModel1 client;
  final String? profileImageUrl;

  DataDetailsScreenClient({required this.client, this.profileImageUrl});

  @override
  _DataDetailsScreenClientState createState() => _DataDetailsScreenClientState();
}

class _DataDetailsScreenClientState
    extends State<DataDetailsScreenClient> {
  final double coverHeight = 220;
  final double profileHeight = 134;

  Widget buildCoverImage() {
    return Stack(
      children: [
        Container(
          child: Container(
            color: kDeepBlueColor,
            child: widget.profileImageUrl != null
                ? Image.network(widget.profileImageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: coverHeight,
            )
                : Placeholder(),
            // You can replace Placeholder with a loading indicator
          ),
        ),

      ],
    );
  }

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundImage: const AssetImage('images/noise_image.webp'),
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: profileHeight / 2 - 6,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(widget.profileImageUrl ?? ''),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/noise_image.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  buildCoverImage(),
                  Positioned(
                    top: top,
                    left: (screenWidth - profileHeight) / 2,
                    child: buildProfileImage(),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Center(
                child: Column(
                  children: [
                    Text(
                      '${widget.client.firstName} ${widget.client.lastName}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 5), // Add some spacing between the name and the level
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                child: SizedBox(
                  width: 500, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('ProfessionalRole: ${widget.client.professionalrole}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),

              SizedBox(height: 1),
              Container(
                // Adjust this value for desired alignment
                child: Center(
                  child: SizedBox(
                    width: 360,
                    child: Divider(
                      color: Color(0xFF969595),
                      thickness: 1.2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(55.0, 0, 0.0, 0.0),
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Review Part Under Construction',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kAmberColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 200,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 0, 55.0, 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => EditClientProfile(client: widget.client, profileImageUrl: widget.profileImageUrl,),
                      ),
                    )
                        .then((updatedUser) {
                      if (updatedUser != null) {
                        setState(() {
                          // Update the widget's user data with the updatedUser data
                          widget.client = updatedUser;
                        });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDeepBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: kBrilliantWhite,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
