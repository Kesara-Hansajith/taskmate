import 'package:flutter/material.dart';
import 'package:taskmate/profile/client/EditClientProfile.dart';
import 'package:taskmate/profile/client/user_model1.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/profile/freelancer/EditFreelancerProfile.dart';
import 'package:taskmate/constants.dart';


class DataDetailsScreenClient extends StatelessWidget {
  final UserModel1 client;
  final String? profileImageUrl;

  DataDetailsScreenClient({required this.client,this.profileImageUrl});

  String? CoverImageUrl;
  final double coverHeight = 220;
  final double profileHeight = 134;

  Widget buildcoverImage() => Stack(
    children: [
      Container(
        height: coverHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://marketplace.canva.com/EAEmBit3KfU/1/0/1600w/canva-black-flatlay-photo-motivational-finance-quote-facebook-cover-myVl9DXwcjQ.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        color: kDeepBlueColor.withOpacity(0.6), // Add opacity to the color
      ),
    ],
  );






  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundImage: AssetImage('images/Dashboard.png'),
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: profileHeight / 2 - 6,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(profileImageUrl ?? ''),
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
            image: AssetImage('images/Dashboard.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  buildcoverImage(),
                  Positioned(
                    top: top,
                    left: (screenWidth - profileHeight) / 2,
                    child: buildProfileImage(),
                  ),
                ],
              ),
              SizedBox(height: 70),
              // First Name + Last Name
              Center(
                child: Text(
                  '${client.firstName} ${client.lastName}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.grey.shade800),
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
                      child: Text('ProfessionalRole: ${client.professionalrole}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(13.0, 2.0, 10.0, 10.0),
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
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


              SizedBox(height: 1),

              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0,
                    10.0), // Adjust this value for desired alignment
                child: Text(
                  'Reviews',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey.shade700),
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
                            color: kAmberColor),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 0, 55.0, 0.0),
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => EditClientProfile(client: client),
                    ),
                     );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDeepBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    //Button icon and Text goes here
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        Text(
                          'Edit Profile',
                          style:
                          TextStyle(color: kBrilliantWhite, fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
