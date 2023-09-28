import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/pages/client/jobs/pending/bidded_freelancer_details.dart';

class BiddedFreelancerCard extends StatelessWidget {
  const BiddedFreelancerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BiddedFreelancerDetails(),
          ),
        );
      },
      child: Ink(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: kDeepBlueColor),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/blank_profile.webp'),
                  radius: 35.0,
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Kesara Hansajith',
                      style: kJobCardTitleTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Logo Designer, Digital Artist, Graphic Designer ',
                        style: kTextStyle,
                      ),
                    ),
                    Text(
                      'LKR. 1500.00',
                      style: kUserDataGatherTitleTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
