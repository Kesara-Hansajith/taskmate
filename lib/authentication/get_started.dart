import 'package:flutter/material.dart';
import 'package:taskmate/authentication/sign_up.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/components/bottom_sub_text.dart';
import 'package:taskmate/authentication/root_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  String? imagePath;


  Future<void> loadImages(String imageUrl) async {
    try {
      await precacheImage(AssetImage(imagePath!), context);
    } catch (e) {
      //Ignored
    }
  }

  @override
  void initState() {
    super.initState();
    loadImages('images/background/get_started.webp');
    loadImages('images/taskmate_logo_light.webp');
    loadImages('images/noise_image.webp');
    loadImages('images/rocket_man.webp');
  }


  void _checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignUp(),
          ),
        );
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MaintenancePage(
              [
                const Image(
                  image: AssetImage('images/no_connection.webp'),
                ),
                Text(
                  'Oops!',
                  style: kSubHeadingTextStyle.copyWith(height: 0.5),
                ),
                const Text(
                  'Wrong Turn...',
                  style: kSubHeadingTextStyle,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Please check your internet connection and try again.',
                    style: kTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                DarkMainButton(
                    title: 'Try Again',
                    process: () {
                      Navigator.of(context).pop();
                    },
                    screenWidth: MediaQuery.of(context).size.width)
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('images/background/get_started.webp'),
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Image.asset('images/taskmate_logo_light.webp'),
              ),
              Expanded(
                flex: 6,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      bottom: 0,
                      child: Container(
                        width: screenWidth,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/noise_image.webp'),
                            repeat: ImageRepeat.repeat,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //GIF will goes here
                            const Expanded(
                              child: Image(
                                image: AssetImage('images/rocket_man.webp'),
                              ),
                            ),
                            //"Get Started" will goes here
                            DarkMainButton(
                              title: 'Get Started',
                              process: () {
                                _checkConnectivity();
                              },
                              screenWidth: screenWidth,
                            ),
                            //Bottom most row of screen
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //"New to TaskMate text will goes here"
                                const BottomSubText('New to TaskMate?'),
                                //"Sign Up" button will goes here
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const SignUp(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: kAmberColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                          ],
                        ),
                      ),
                    )
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
