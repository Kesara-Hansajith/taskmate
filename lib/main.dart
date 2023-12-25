import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:taskmate/constants.dart';
import 'package:get/get.dart';
import 'package:taskmate/firebase_options.dart';
import 'package:taskmate/profile/client/user_repository1.dart';
import 'package:taskmate/profile/freelancer/user_repository.dart';
import 'package:taskmate/authentication/splash_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: kDeepBlueColor, //
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UserRepository1());
  Get.put(UserRepository());

  runApp(
    const Taskmate(),
  );
}

class Taskmate extends StatelessWidget {
  // UserModel1 client;
  const Taskmate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      home:  const SafeArea(
        child: SplashScreen(),

      ),
    );
  }
}
