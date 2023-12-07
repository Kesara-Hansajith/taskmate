import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taskmate/dashboard/scan_qr.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({super.key});

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  void shareApp() async {
    final result =
        await Share.shareWithResult('check out my website https://example.com');

    if (result.status == ShareResultStatus.success) {}
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Invite Friends',
            style: kHeadingTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 4,
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
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    'Discover a world of opportunities for Sri Lankan freelancers with our app! Join us to showcase your skills, find exciting gigs, and empower the freelance community in Sri Lanka. Download now and embark on a journey of creativity, flexibility, and endless possibilities!',
                    textAlign: TextAlign.center,
                    style: kTextStyle,
                  ),
                  Image.asset('images/playstore.png'),
                  SizedBox(
                    width: screenWidth,
                    child: DarkMainButton(
                      title: 'Scan QR Code',
                      process: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ScanQR(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: screenWidth,
                    child: LightMainButton(
                      title: 'Share',
                      process: shareApp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
