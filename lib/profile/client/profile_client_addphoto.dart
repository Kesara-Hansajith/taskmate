import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmate/profile/client/data_details_screen_client.dart';
import 'package:taskmate/profile/client/profile_client.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:taskmate/profile/client/user_model1.dart';
import 'package:taskmate/profile/freelancer/upload_profile_image.dart';
import 'package:taskmate/constants.dart';

class ProfileClientAddphoto extends StatefulWidget {
  final UserModel1 client;

  const ProfileClientAddphoto({Key? key, required this.client}) : super(key: key);

  @override
  _ProfileClientAddphotoState createState() => _ProfileClientAddphotoState();
}

class _ProfileClientAddphotoState extends State<ProfileClientAddphoto> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
  final TextEditingController passwordController = TextEditingController();

  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;


  List<String> selectedServices = [];
  File? selectedImage;

  String? get existingUserId => null;

  void updateData() {
    if (formKey.currentState!.validate()) {
      setState(() {
        dataSubmitted = true; });}}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/noise_image.png'),
                fit: BoxFit.cover,),),),
    SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ProfileClient(),),);},
                      icon: Icon(Icons.arrow_back_ios_sharp, size: 30.0),
                      color: kDeepBlueColor,),
                    Padding(
                      padding: EdgeInsets.only(top: 2, left: 0, right: 15),
                      child: Text(
                        'Add a Profile Photo',
                        style: TextStyle(
                          fontSize: 32, // Adjust the font size as needed
                          fontWeight: FontWeight.w600,
                          color:
                              kDeepBlueColor, ),),),],),
              ),
              SizedBox(height: 100),


              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 150,
                      backgroundColor: Colors.transparent,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!) // Display selected/captured image
                          : profileImageUrl != null
                          ? NetworkImage(profileImageUrl!)
                          : AssetImage('images/iconamoon_profile-circle-thin.png') as ImageProvider<Object>,
                    ),

                    SizedBox(height: 120),
                    ElevatedButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final pickedImage = await picker.pickImage(source: ImageSource.gallery);

                        if (pickedImage != null) {
                          // Upload image to Firebase Storage and get the download URL
                          final imageFile = File(pickedImage.path);
                          final String downloadUrl = await uploadProfileImage(imageFile);

                          // Refresh the UI if needed
                          setState(() {
                            selectedImage= File(pickedImage.path);
                          });}
                        },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF071689),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        minimumSize: Size(320, 38), // Adjust the width and height as needed
                      ),
                      child: Text("Choose a Photo from Gallery",style: TextStyle(fontSize: 18,),),
                    ),
                    SizedBox(height: 5),


                    ElevatedButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final pickedImage = await picker.pickImage(source: ImageSource.camera);

                        if (pickedImage != null) {
                          setState(() {
                            selectedImage = File(pickedImage.path);});}
                        },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF5696FA),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        minimumSize: Size(320, 38), // Adjust the width and height as needed
                      ),
                      child: Text("Take a Photo",style : TextStyle(fontSize: 18,),),
                    ),
                    SizedBox(height: 40,),

                    ElevatedButton(
                      onPressed: () async {
                        if (selectedImage != null) {
                          // Upload image to Firebase Storage and get the download URL
                          final String downloadUrl = await uploadImageToFirebaseStorage(selectedImage!);

                          // Create a Firestore document and save the data
                          await FirebaseFirestore.instance.collection('Clients').doc(existingUserId).set({
                            'firstName': widget.client.firstName,
                            'lastName': widget.client.lastName,
                            'email': widget.client.email,
                            'password': widget.client.password,
                            'address': widget.client.address,
                            'zipcode': widget.client.zipcode,
                            'street': widget.client.street,
                            'birthday': widget.client.birthday,
                            'gender': widget.client.gender,
                            'province': widget.client.province,
                            'city': widget.client.city,
                            'phoneNo': widget.client.phoneNo,
                            'profilePhotoUrl': downloadUrl,
                            'professionalRole': widget.client.professionalrole,

                          });

                          // Navigate back to the previous page or any other page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DataDetailsScreenClient(client: widget.client),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF071689),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        minimumSize: Size(320, 55), // Adjust the width and height as needed
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],),),],),),],),);}

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask;

      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }
}

