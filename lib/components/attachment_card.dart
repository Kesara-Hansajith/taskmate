import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';
import 'package:dotted_border/dotted_border.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    super.key,
    required this.cardChild,
  });

  final Widget? cardChild;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: Container(
          height: 200,
          color: kLowOpacityLightBlueColor,
          child: Center(
            child: cardChild,
          ),
        ),
      ),
    );
  }
}
