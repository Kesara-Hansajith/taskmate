import 'package:flutter/material.dart';
import 'package:taskmate/components/attachment_card.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/review_card.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/dashboard/freelancer/dashboard.dart';
import 'package:taskmate/dashboard/freelancer/edit_profile.dart';

class BiddedFreelancerProfile extends StatefulWidget {
  final String freelancerName;
  final String skills;
  final String profilePhotoUrl;
  final String Level;
  final String professionalRole;
  final String bio;
  final String hourlyRate;

   BiddedFreelancerProfile({
    Key? key,
    required this.freelancerName,
    required this.skills,
    required this.profilePhotoUrl,
     required this.Level,
     required this.professionalRole,
     required this.bio,
     required this.hourlyRate,
  }) : super(key: key);


  @override
  State<BiddedFreelancerProfile> createState() =>
      _BiddedFreelancerProfileState();
}

class _BiddedFreelancerProfileState extends State<BiddedFreelancerProfile> {
  void _navigateToEditProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EditProfile(),
      ),
    );
  }

  void _navigateToBackward() {
    Navigator.of(context).pop();
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  //TODO Messaging to Freelancer
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 6.0,
                                  backgroundColor: kAmberColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: const Text(
                                  'Message',
                                  style: TextStyle(
                                    color: kDeepBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth,
                        height: screenHeight / 15,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _navigateToBackward,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.navigate_before,
                                  size: 35.0,
                                ),
                                Text('Back'),
                              ],
                            ),
                          ),
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
                      backgroundImage: widget.profilePhotoUrl.isNotEmpty
                          ? NetworkImage(widget.profilePhotoUrl) as ImageProvider<Object> // Explicitly specify the type
                          : AssetImage('images/blank_profile.webp') as ImageProvider<Object>, // Explicitly specify the type
                      radius: 40,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.freelancerName,
                    style: kSubHeadingTextStyle,
                  ),
                  Text(
                    widget.Level,
                    style: kTextStyle.copyWith(color: kOceanBlueColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Professional Role - ${widget.professionalRole}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child:  UserDataGatherTitle(
                            title: 'Hourly Rate : LKR.${widget.hourlyRate}',
                          ),
                        ),
                        const UserDataGatherTitle(title: 'Overview'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            widget.bio,
                            style: kTextStyle,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            width: screenWidth / 1.2,
                            child: const Divider(
                              color: kDarkGreyColor,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        UserDataGatherTitle(
                          title: 'Portfolio',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: const <Widget>[
                              Expanded(
                                child: AttachmentCard(cardChild: null),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: AttachmentCard(cardChild: null),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            width: screenWidth / 1.2,
                            child: const Divider(
                              color: kDarkGreyColor,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        UserDataGatherTitle(
                          title: 'Reviews',
                        ),
                        ReviewCard(
                          imagePath: 'images/blank_profile.webp',
                          jobTitle: 'Graphic designer for family care product',
                          feedback:
                              'Great! Very creative and had great ideas! ',
                          username: 'Nugera Gomez',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: DarkMainButton(
                              title: 'Edit Profile',
                              process: _navigateToEditProfile,
                              screenWidth: screenWidth),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
