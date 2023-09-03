import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:dotted_border/dotted_border.dart';

class Files extends StatefulWidget {
  const Files({
    super.key,
  });

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              'Submit work for get the payment',
              style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              //TODO Add photo functionality
                            },
                            child: Container(
                              height: screenHeight / 6,
                              color: kLowOpacityLightBlueColor,
                              child: const Center(
                                child: Text('+ Add'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //TODO Delete photo functionality
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.delete,
                            color: kDarkGreyColor,
                          ),
                          Text(
                            'Delete',
                            style: kTextStyle,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              //TODO Add photo functionality
                            },
                            child: Container(
                              height: screenHeight / 6,
                              color: kLowOpacityLightBlueColor,
                              child: const Center(
                                child: Text('+ Add'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //TODO Delete photo functionality
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.delete,
                            color: kDarkGreyColor,
                          ),
                          Text(
                            'Delete',
                            style: kTextStyle,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          DarkMainButton(
              title: 'Submit Work',
              process: () {
                //TODO Submit files to firebase storage functionality
              },
              screenWidth: screenWidth),
          LightMainButton(
              title: 'Message',
              process: () {
                //TODO Forward to messaging part
              },
              screenWidth: screenWidth)
        ],
      ),
    );
  }
}
