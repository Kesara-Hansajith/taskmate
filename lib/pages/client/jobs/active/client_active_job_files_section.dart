import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:dotted_border/dotted_border.dart';

class ClientActiveJobFiles extends StatefulWidget {
  const ClientActiveJobFiles({
    super.key,
  });

  @override
  State<ClientActiveJobFiles> createState() => _ClientActiveJobFilesState();
}

class _ClientActiveJobFilesState extends State<ClientActiveJobFiles> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                  'Download the submissions',
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
                            vertical: 8.0,
                          ),
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
                                    child: Text(''),
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
                                Icons.download,
                                color: kDarkGreyColor,
                              ),
                              Text(
                                'Download',
                                style: kTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
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
                                    child: Text(''),
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
                                Icons.download,
                                color: kDarkGreyColor,
                              ),
                              Text(
                                'Download',
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
                  title: 'Accept',
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
        ),
      ),
    );
  }
}
