import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:taskmate/bottom_nav_bar/freelancer/proposals.dart';

import 'package:taskmate/client_home_page.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:taskmate/authentication/root_page.dart';
import 'package:taskmate/components/client/post_a_job.dart';
import 'package:taskmate/dashboard/freelancer/dashboard.dart';
import 'package:taskmate/dashboard/freelancer/edit_profile.dart';
import 'package:taskmate/dashboard/freelancer/profile.dart';

import 'package:taskmate/pages/client/client_post_job.dart';
import 'package:taskmate/pages/client/jobs/pending/bidded_freelancer_details.dart';
import 'package:taskmate/pages/client/jobs/pending/bidded_freelancers.dart';
import 'package:taskmate/pages/client/jobs/pending/client_pending_jobs.dart';
import 'package:taskmate/pages/freelancer/proposals/pending_jobs_pages/pending_jobs.dart';
import 'package:taskmate/profile/client/EditClientProfile.dart';

import 'package:taskmate/profile/client/profile_client.dart';
import 'package:taskmate/profile/client/user_model1.dart';
import 'package:taskmate/profile/client/user_repository1.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_1.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_2.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_3.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_4.dart';
import 'package:taskmate/profile/freelancer/user_repository.dart';

// import 'package:taskmate/verify_identity.dart';
// import 'FreelancerDashboard/Dashboard.dart';

import 'firebase_options.dart';
//imported pages
import 'package:taskmate/authentication/splash_screen.dart';
import 'package:taskmate/authentication/log_in.dart';
import 'package:taskmate/authentication/take_action.dart';
import 'package:taskmate/authentication/sign_up.dart';
import 'package:taskmate/authentication/create_my_account_1.dart';
import 'package:taskmate/authentication/get_started.dart';
import 'package:taskmate/authentication/verify_email.dart';
import 'package:taskmate/bottom_nav_bar/freelancer/jobs.dart';
import 'package:taskmate/job_details.dart';
import 'package:taskmate/authentication/forget_password.dart';

import 'package:taskmate/freelancer_home_page.dart';
import 'pages/freelancer/proposals/active_jobs_pages/active_job_details.dart';
//import 'package:taskmate/verify_identity.dart';

void main() async {
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
      home:  SafeArea(
        child: ClientHomePage(),
      ),
    );
  }
}
