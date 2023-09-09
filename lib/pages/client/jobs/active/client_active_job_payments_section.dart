import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/constants.dart';

class ClientActiveJobPayment extends StatefulWidget {
  const ClientActiveJobPayment({super.key});

  @override
  State<ClientActiveJobPayment> createState() => _ClientActiveJobPaymentState();
}

class _ClientActiveJobPaymentState extends State<ClientActiveJobPayment> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  'Payment Summary',
                  style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Requested'),
                    Text('LKR. 1500.00'),
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
                  children: const <Widget>[
                    Text('In Progress'),
                    Text('LKR.  0.00'),
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
                  children: const <Widget>[
                    Text('Released to Freelancer'),
                    Text(
                      'LKR.  0.00',
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              DarkMainButton(
                  title: 'Release Payment',
                  process: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MaintenancePage(
                          [
                            const Image(
                              image: AssetImage('images/message.webp'),
                            ),
                            Text(
                              'Are You Sure?',
                              style: kSubHeadingTextStyle.copyWith(height: 0.5),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'If you choose Yes, then the amount will sent to freelancer account',
                                style: kTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DarkMainButton(
                              title: 'Yes, I ‘m Sure',
                              process: () {
                                Navigator.of(context).pop();
                              },
                              screenWidth: screenWidth,
                            ),
                            LightMainButton(
                              title: 'Cancel',
                              process: () {},
                              screenWidth: screenWidth,
                            ),
                          ],
                        );
                      },
                    );
                    //TODO Request Payment functionality
                  },
                  screenWidth: screenWidth),
              LightMainButton(
                  title: 'Message',
                  process: () {
                    //TODO Forward to messaging functionality
                  },
                  screenWidth: screenWidth)
            ],
          ),
        ),
      ),
    );
  }
}
