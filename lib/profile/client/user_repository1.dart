import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/profile/client/user_model1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserRepository1 extends GetxController {
  static UserRepository1 get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Stream<List<UserModel1>> getClientsStream() {
    return _db.collection("Clients").snapshots().map(
          (querySnapshot) => querySnapshot.docs.map((doc) => UserModel1.fromJson(doc.data(), doc.id))
          .toList(),
    );
  }


  createUser(UserModel1 client) async {
    try {
      // Get a server timestamp to use as the document ID
      FieldValue serverTimestamp = FieldValue.serverTimestamp();

      // Create a reference to the document using the server timestamp
      DocumentReference docRef = _db.collection("Clients").doc();

      // Set the document ID as the server timestamp
      await docRef.set(client.toJson(), SetOptions(merge: true));

      Get.snackbar(
        "Success",
        "Your Account has been Created",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
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
