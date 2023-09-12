import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/pending/bid_freelancer_card.dart';

class BidFreelancerList extends StatefulWidget {
  const BidFreelancerList({super.key});

  @override
  State<BidFreelancerList> createState() => _BidFreelancerListState();
}

class _BidFreelancerListState extends State<BidFreelancerList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Pending Proposals',
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
            children: [
              BidFreelancerCard(),
            ],
          ),
        ),
      ),
    );
  }
}
