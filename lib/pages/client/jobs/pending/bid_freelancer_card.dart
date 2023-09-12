import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

//Hardcoded

class BidFreelancerCard extends StatelessWidget {
  const BidFreelancerCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          width: screenWidth,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: kDeepBlueColor,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: <Widget>[
              const Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/blank_profile_picture.webp'),
                  radius: 50.0,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Kesara Hansajith',
                        style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Logo Designer | Digital Artist | Graphic Designer ',
                        style: kTextStyle,
                      ),
                      Text(
                        'LKR. 1500.00',
                        style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
