import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class BidDetails extends StatefulWidget {
  const BidDetails({super.key});

  @override
  State<BidDetails> createState() => _BidDetailsState();
}

class _BidDetailsState extends State<BidDetails> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Bid Details',
            style: kHeadingTextStyle,
          ),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.navigate_before,
              color: kDeepBlueColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('images/blank_profile_picture.webp'),
                    radius: 30.0,
                  ),
                  title: Text('Kesara Hansajith'),
                  subtitle:
                      Text('Logo Designer | Digital Artist | Graphic Designer'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 8.0,
                ),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bid Amount'),
                      const Text('LKR. 1500.00'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
