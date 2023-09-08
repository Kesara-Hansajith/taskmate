import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:taskmate/profile/client/user_model1.dart';

class EditClientProfile extends StatefulWidget {
  final UserModel1 client; // Add this line to define the client parameter

  EditClientProfile({required this.client});

  @override
  _EditClientProfileState createState() => _EditClientProfileState();
}

class _EditClientProfileState extends State<EditClientProfile> {
  final TextEditingController professionalRoleController =
  TextEditingController();

  void updateData() {
    // Your validation and data update logic here
  }

  Future<File?> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      return imageFile;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Profile1(
        professionalRoleController: professionalRoleController,
        parentContext: context,
        client: widget.client,
      ),
    );
  }
}

class Profile1 extends StatefulWidget {
  final TextEditingController professionalRoleController;
  final BuildContext parentContext;
  final UserModel1 client;

  Profile1({
    required this.professionalRoleController,
    required this.parentContext,
    required this.client,
  });

  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _submitDetails() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user != null) {
      final userId = user.uid;

      await FirebaseFirestore.instance.collection('Clients').doc(userId).update({
        'professionalrole': widget.professionalRoleController.text,
        // Add other fields here and update their values
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Your UI components here

            // Example: Replace IconButton with the user interaction of your choice
          ],
        ),
      ),
    );
  }
}
