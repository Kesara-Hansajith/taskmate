import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmate/profile/client/user_model1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository1 extends GetxController {
  static UserRepository1 get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Stream<List<UserModel1>> getClientsStream() {
    return _db.collection("Clients").snapshots().map(
          (querySnapshot) => querySnapshot.docs
          .map((doc) => UserModel1.fromJson(doc.data(), doc.id))
          .toList(),
    );
  }

  createUser(UserModel1 client, String customDocumentID) async {
    try {
      // Create a reference to the Firestore collection
      CollectionReference collection = _db.collection("Clients");

      // Add a new document with a custom document ID (customDocumentID)
      DocumentReference docRef = collection.doc(customDocumentID);


      // Create a document with a custom document ID (customDocumentID) and user data
      await docRef.set({
        'UserUID': customDocumentID, // Store the customDocumentID as a field in the document
        ...client.toJson(), // Spread the user data into the document
      });

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
