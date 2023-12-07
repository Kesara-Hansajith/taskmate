import 'package:flutter/material.dart';
import 'package:taskmate/classes/cus_snackbar.dart';
import 'package:taskmate/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  void composeEmail() async {
    final url = Uri.encodeFull('mailto:helpme.taskmate@gmail.com');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          CusSnackBar(
            backColor: kWarningRedColor,
            time: 3,
            title: 'Couldn\'t send the mail.',
            icon: null,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Help & Support',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 80.0,
              ),
              const Text(
                'For any kind of help and support please write us on the below mentioned mail ID. \nThank you!',
                style: kTextStyle,
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: composeEmail,
                child: const Text(
                  'helpme.taskmate@gmail.com',
                  style: TextStyle(color: kDeepBlueColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
