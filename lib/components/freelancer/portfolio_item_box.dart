import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_4.dart';

class PortfolioItemBox extends StatelessWidget {
  const PortfolioItemBox({
    super.key,
    required this.screenWidth,
    required this.image,
  });

  final double screenWidth;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileFreelancer4(),
          ),
        );
      },
      child: Container(
        width: screenWidth,
        height: 100.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: kDarkGreyColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: image,
      ),
    );
  }
}
