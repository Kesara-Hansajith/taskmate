import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/Dashboard/FreelancerDashboard/Dashboard.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/noise_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 0, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>  Dashboard(),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp, size: 30.0),
                      color: kDeepBlueColor,
                    ),
                    SizedBox(width: 80.0,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Balance',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w600,
                          color: kDeepBlueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:50),
              Container(
                height: 80.0,
                margin: const EdgeInsets.symmetric(horizontal: 35.0),
                width: screenWidth,
                decoration: BoxDecoration(
                  color: kOceanBlueColor.withOpacity(0.2),
                  border: Border.all(color: kOceanBlueColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 30.0,
                      child: Text(
                        'Net Profit',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: kDeepBlueColor,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20.0,
                      child: Container(
                        width: 110.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: kOceanBlueColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center( // Wrap the Text widget with Center
                          child: Text(
                            "LKR.1000.00",
                            style: TextStyle(
                              color: kDeepBlueColor, // Text color
                              fontSize: 16.0,     // Adjust font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height:50),
              Container(
                height: 80.0,
                margin: const EdgeInsets.symmetric(horizontal: 35.0),
                width: screenWidth,
                decoration: BoxDecoration(
                  color: kOceanBlueColor.withOpacity(0.2),
                  border: Border.all(color: kOceanBlueColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 30.0,
                      child: Text(
                        'Net Profit',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: kDeepBlueColor,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20.0,
                      child: Container(
                        width: 110.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: kOceanBlueColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center( // Wrap the Text widget with Center
                          child: Text(
                            "LKR.1000.00",
                            style: TextStyle(
                              color: kDeepBlueColor, // Text color
                              fontSize: 16.0,     // Adjust font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height:50),
              Container(
                height: 80.0,
                margin: const EdgeInsets.symmetric(horizontal: 35.0),
                width: screenWidth,
                decoration: BoxDecoration(
                  color: kOceanBlueColor.withOpacity(0.2),
                  border: Border.all(color: kOceanBlueColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 30.0,
                      child: Text(
                        'Net Profit',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: kDeepBlueColor,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20.0,
                      child: Container(
                        width: 110.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: kOceanBlueColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center( // Wrap the Text widget with Center
                          child: Text(
                            "LKR.1000.00",
                            style: TextStyle(
                              color: kDeepBlueColor, // Text color
                              fontSize: 16.0,     // Adjust font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
