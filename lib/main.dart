import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//imported pages
import 'package:taskmate/authentication/splash_screen.dart';
import 'package:taskmate/authentication/log_in.dart';
import 'package:taskmate/authentication/take_action.dart';
import 'package:taskmate/authentication/sign_up.dart';
import 'package:taskmate/authentication/create_my_account_1.dart';
import 'package:taskmate/authentication/get_started.dart';
import 'package:taskmate/authentication/verify_email.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const Taskmate(),
  );
}

class Taskmate extends StatelessWidget {
  const Taskmate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      home: const SafeArea(
        child: SplashScreen(),
      ),
    );
  }
}
