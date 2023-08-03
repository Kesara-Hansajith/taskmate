import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: const Image(
        image: AssetImage('images/gear.webp'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text(
            'We’re ',
            style: kSubHeadingTextStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            'Under Maintenance',
            style: kSubHeadingTextStyle,
            textAlign: TextAlign.center,
          )
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(kDeepBlueColor),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text('Okay'),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 20.0,
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
