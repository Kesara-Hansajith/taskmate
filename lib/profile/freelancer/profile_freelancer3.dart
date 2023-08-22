import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer2.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer4.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_addphoto.dart';
import 'package:taskmate/profile/freelancer/upload_profile_image.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';

import 'package:taskmate/profile/freelancer/user_data_gather_title.dart';


import '../../constants.dart';
import '../client/profile_client.dart';

class ProfileFreelancer3 extends StatefulWidget {
  final UserModel user;
  const ProfileFreelancer3({required  this.user});

  @override
  _ProfileFreelancer3State createState() => _ProfileFreelancer3State();
}

class _ProfileFreelancer3State extends State<ProfileFreelancer3> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController sociallinkController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController servicesController = TextEditingController();
  final TextEditingController professionalRoleController = TextEditingController();
  final TextEditingController hourlyrateController = TextEditingController();
  final TextEditingController imageurl1Controller = TextEditingController();
  final TextEditingController imageurl2Controller = TextEditingController();
  final TextEditingController imageurl3Controller = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController itemdesController = TextEditingController();


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedImageUrl1;
  String? selectedImageUrl2;
  String? selectedImageUrl3;
  String? selectedFilePath;
  String? selectedSkills;
  bool dataSubmitted = false;




  Future<String> uploadFile(File file, String filename, String fileType) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("User not authenticated.");
    }
    try {
      Reference storageRef = _storage.ref().child('uploads/${user.uid}/$filename');
      TaskSnapshot taskSnapshot = await storageRef.putFile(file);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      return '';
    }
  }


  void updateData() {
    if (formKey.currentState!.validate()) {
      setState(() {
        dataSubmitted = true; });}}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/noise_image.webp'),),),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    const Center(
                    child: Text(
                      'Set Up Your',
                      style: kHeadingTextStyle,),),
                        Center(
                          child: Text('Freelancer Profile', style: TextStyle(fontSize: 25,color: Color(0xFF16056B),fontWeight: FontWeight.bold, ).copyWith(height: 1.0),),),

                          SizedBox(height:12),

                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const UserDataGatherTitle(title: 'Add portfolio link'),
                              TextFormField(
                                controller: sociallinkController,
                                decoration: InputDecoration(
                                  hintText: 'Add your any portfolio link here',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFF4B4646)),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x4B4646),
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4B4646),),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter URL ';}
                                  final urlPattern = RegExp(
                                    r"^(https?://)?([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(/\S*)?$",
                                    caseSensitive: false,
                                    multiLine: false,
                                  );
                                  if (!urlPattern.hasMatch(value)) {
                                    return 'Please enter a valid URL';
                                  }
                                  return null;
                                },),],),),


                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const UserDataGatherTitle(title: 'Add Portfolio Items'),
                              ],),),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 120,
                                child: GestureDetector(
                                  onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                      );
                                    },

                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFF4B4646),),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: selectedImageUrl1 != null
                                        ? Image.file(
                                      File(selectedImageUrl1!),
                                      fit: BoxFit.cover,
                                    ): Center(
                                    child: Text(
                                      '+ Add',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF4B4646), ),),),),),),],),
                                SizedBox(height: 14),

                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 120,
                                      child: GestureDetector(
                                        onTap: () async {

                                            // Navigate to the profile_freelancer4 page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                            );
                                          },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFF4B4646),),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: selectedImageUrl2!= null
                                              ? Image.file(
                                            File(selectedImageUrl2!),
                                            fit: BoxFit.cover,
                                          ): Center(
                                            child: Text(
                                              '+ Add',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF4B4646), ),),),),),),],),
                                SizedBox(height: 14),

                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 120,
                                      child: GestureDetector(
                                        onTap: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                            );

                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFF4B4646),),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: selectedImageUrl3 != null
                                              ? Image.file(
                                            File(selectedImageUrl3!),
                                            fit: BoxFit.cover,
                                          ): Center(
                                            child: Text(
                                              '+ Add',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF4B4646), ),),),),),),],),
                                SizedBox(height: 10),


                                 // Adjust the position as needed

    ],
                ),
                          ),
                                SizedBox(height: 16,),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                       if (formKey.currentState!.validate()) {
                                         // Validated successfully, update the user data and navigate to the next page
                                         UserModel updatedUser = UserModel(
                                           firstName: widget.user.firstName,
                                           lastName: widget.user.lastName,
                                           address: widget.user.address,
                                           zipcode: widget.user.zipcode,
                                           street: widget.user.street,
                                           birthday: widget.user.birthday,
                                           gender: widget.user.gender,
                                           province: widget.user.province,
                                           city: widget.user.city,
                                           phoneNo: widget.user.phoneNo,
                                           hourlyRate: widget.user.hourlyRate,
                                           bio: widget.user.bio,
                                           skills: widget.user.skills,
                                           services: widget.user.services,
                                           sociallink: sociallinkController.text,

                                         );

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProfileFreelancerAddphoto(user: updatedUser),
                                            ),
                                          );
                                       }
                                    },
                                    child: Text('Save & Next',
                                      style: TextStyle(fontSize: 16), // Adjust the font size as needed
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF16056B), // Change the background color
                                      onPrimary: Colors.white,    // Change the text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13), // Adjust the border radius as needed
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15), ),),),
                                SizedBox(height: 20,),



                              ],),),
    ),
    ),),
    );
  }
}


