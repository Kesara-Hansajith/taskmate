import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Balance',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: screenWidth,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: kLowOpacityLightBlueColor,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: kOceanBlueColor,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Poster Design',
                            style: kJobCardTitleTextStyle.copyWith(
                              fontSize: 20.0,
                            ),
                          ),
                          const Text(
                            'Net Profit',
                            style: kJobCardTitleTextStyle,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color: kLightBlueColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'LKR 1000',
                          style: kJobCardTitleTextStyle.copyWith(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
