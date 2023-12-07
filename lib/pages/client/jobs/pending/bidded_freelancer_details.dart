import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/pending/bidded_freelancer_profile.dart';

class BiddedFreelancerDetails extends StatefulWidget {
  final String bidDescription;
  final String bidAmount;
  final String delivery;
  final String jobTitle;
  final QueryDocumentSnapshot pendingJobDoc;
  final String freelancerName; // Include freelancerName in the parameters
  final String skills;
  final String profilePhotoUrl;
  final String Level;
  final String professionalRole;
  final String bio;
  final String hourlyRate;



  const BiddedFreelancerDetails({ Key? key,
    required this.bidDescription,
    required this.bidAmount,
    required this.delivery,
    required this.jobTitle,
    required this.pendingJobDoc,
    required this.freelancerName, // Add freelancerName to the constructor
    required this.skills,
    required this.profilePhotoUrl,
    required this.Level,
    required this.professionalRole,
    required this.bio,
    required this.hourlyRate,
  }) : super(key: key);


  @override
  State<BiddedFreelancerDetails> createState() =>
      _BiddedFreelancerDetailsState();
}

class _BiddedFreelancerDetailsState extends State<BiddedFreelancerDetails> {
  void navigateToFreelancerProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BiddedFreelancerProfile(
            freelancerName: widget.freelancerName,
            skills: widget.skills,
            profilePhotoUrl: widget.profilePhotoUrl,
            Level: widget.Level,
            professionalRole: widget.professionalRole,
            bio: widget.bio,
            hourlyRate: widget.hourlyRate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Proposal Details',
            style: kHeadingTextStyle,
          ),
          elevation: 4.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.navigate_before,
              color: kDeepBlueColor,
            ),
          ),
          flexibleSpace: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'images/noise_image.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight - appBarHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: widget.profilePhotoUrl.isNotEmpty
                            ? NetworkImage(widget.profilePhotoUrl) as ImageProvider<Object> // Explicitly specify the type
                            : AssetImage('images/blank_profile.webp') as ImageProvider<Object>, // Explicitly specify the type
                        radius: 35.0,
                      ),
                      title: Text(
                        widget.freelancerName, // Use freelancerName
                        style:
                            kJobCardTitleTextStyle.copyWith(color: kJetBlack),
                      ),
                      subtitle: Text(
                        widget.skills,
                        style: kTextStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Job Title',
                          style: kUserDataGatherTitleTextStyle.copyWith(
                              fontSize: 15),
                        ),
                        Text(
                          widget.jobTitle,
                          style: kTextStyle,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Bid Amount',
                          style: kUserDataGatherTitleTextStyle.copyWith(
                              fontSize: 15),
                        ),
                        Text(
                          'LKR. ${widget.bidAmount}',
                          style: kTextStyle,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Delivery within',
                          style: kUserDataGatherTitleTextStyle.copyWith(
                              fontSize: 15),
                        ),
                        Text(
                          '${widget.delivery} days',
                          style: kTextStyle,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Freelancer\'s Description',
                          style: kUserDataGatherTitleTextStyle.copyWith(
                              fontSize: 15),
                        ),
                        Text(
                          widget.bidDescription,
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  DarkMainButton(
                    title: 'Hire Now',
                    process: () async {
                      try {
                        // Update the status to "active" in Firestore
                        await widget.pendingJobDoc.reference.update({'status': 'active'});

                        // Update the budget in the main document with the bidAmount value
                        await widget.pendingJobDoc.reference.update({'budget': widget.bidAmount});

                        // Show a SnackBar indicating success
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Freelancer hired successfully!'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        // TODO: Add any other processing logic if needed
                      } catch (e) {
                        // Handle errors, and show a SnackBar indicating failure
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error hiring freelancer: $e'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    screenWidth: screenWidth,
                  ),


                  LightMainButton(
                      title: 'View Profile',
                      process: navigateToFreelancerProfile,
                      screenWidth: screenWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
