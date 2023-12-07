import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/constants.dart';

class Payments extends StatefulWidget {
  final String budgetField;
  final QueryDocumentSnapshot activeJobDoc;

  const Payments(
      {required this.budgetField, required this.activeJobDoc, super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

void requestPayment(
    QueryDocumentSnapshot activeJobDoc, BuildContext context) async {
  try {
    // Reference to Firestore document
    final DocumentReference docRef = activeJobDoc.reference;

    // Update the 'payment' field to 'Request'
    await docRef.update({'payment': 'Request'});

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment requested successfully.'),
      ),
    );
  } catch (e) {
    print('Error requesting payment: $e');
    // Handle errors here, e.g., show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error requesting payment: $e'),
      ),
    );
  }
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Payment Summary',
              style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Requested'),
                  Text(
                    'LKR. ${widget.budgetField}',
                    style: kTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('In Progress'),
                  Text('LKR. ${widget.activeJobDoc['Precentage'] ?? 300}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Released to Freelancer'),
                  Text(
                    'LKR. ${widget.activeJobDoc['releaseMoney']} ',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            DarkMainButton(
              title: 'Request Payment',
              process: () {
                requestPayment(widget.activeJobDoc,
                    context); // Call the method to request payment
              },
              screenWidth: screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}
