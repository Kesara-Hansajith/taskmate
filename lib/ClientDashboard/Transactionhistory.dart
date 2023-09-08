import 'package:flutter/material.dart';
import 'package:taskmate/ClientDashboard/Dashboard.dart';
import 'package:taskmate/constants.dart';


class Transactionhistory extends StatefulWidget {
  const Transactionhistory({Key? key}) : super(key: key);

  @override
  State<Transactionhistory> createState() => _TransactiohistoryState();
}

class _TransactiohistoryState extends State<Transactionhistory> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>  Dashboard(),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp,size: 30.0),
                      color: kDeepBlueColor,

                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Transactiohistory',
                        style: TextStyle(
                          fontSize: 38, // Adjust the font size as needed
                          fontWeight: FontWeight.w600,
                          color: kDeepBlueColor, // Adjust the text color as needed
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

