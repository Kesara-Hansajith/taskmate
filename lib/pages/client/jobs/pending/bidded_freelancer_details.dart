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

  const BiddedFreelancerDetails({ Key? key,
    required this.bidDescription,
    required this.bidAmount,
    required this.delivery,
    required this.jobTitle,
  }) : super(key: key);


  @override
  State<BiddedFreelancerDetails> createState() =>
      _BiddedFreelancerDetailsState();
}

class _BiddedFreelancerDetailsState extends State<BiddedFreelancerDetails> {
  void navigateToFreelancerProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BiddedFreelancerProfile(),
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
        body: SingleChildScrollView(
          child: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('images/blank_profile.webp'),
                      ),
                      title: Text(
                        'Kesara Hansajith',
                        style:
                            kJobCardTitleTextStyle.copyWith(color: kJetBlack),
                      ),
                      subtitle: Text(
                        'Logo Designer, Digital Artist, Graphic Designer',
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
                      process: () {},
                      screenWidth: screenWidth),
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
