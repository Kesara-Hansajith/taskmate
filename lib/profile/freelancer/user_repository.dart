import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void>updateUserRecord(UserModel user)async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }


  createUser(UserModel user) async {
    try {
      await _db.collection("Users").add(user.toJson());
      Get.snackbar(
        "Success",
        "Your Account has been Created",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

    }
    catch (error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(error.toString());
    }


  }


}
