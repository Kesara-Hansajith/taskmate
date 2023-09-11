import 'package:flutter/material.dart';
import 'package:taskmate/client_dashboard/Dashboard.dart';
import 'package:taskmate/constants.dart';

import '../profile/client/user_model1.dart';


class TransactionhistoryClient extends StatefulWidget {
  final UserModel1 client;
  final String? profileImageUrl;

  const TransactionhistoryClient({required this.client, this.profileImageUrl}) ;

  @override
  State<TransactionhistoryClient> createState() => _TransactionhistoryClientState();
}

class _TransactionhistoryClientState extends State<TransactionhistoryClient> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return SafeArea(
      child: Scaffold(
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
                              builder: (context) =>  DashboardClient(client: widget.client,profileImageUrl: widget.profileImageUrl,),
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
                            fontSize: 28, // Adjust the font size as needed
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
      ),
    );
  }
}

