import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer3.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_addphoto.dart';
import 'package:taskmate/profile/freelancer/upload_profile_image.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:taskmate/profile/freelancer/user_repository.dart';

import '../../constants.dart';
import '../client/profile_client.dart';

class ProfileFreelancer2 extends StatefulWidget {
  final UserModel user;

  ProfileFreelancer2({required  this.user});

  @override
  _ProfileFreelancer2State createState() => _ProfileFreelancer2State();
}

class _ProfileFreelancer2State extends State<ProfileFreelancer2> {
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
  final TextEditingController hourlyrateController = TextEditingController();
  final TextEditingController imageurl1Controller = TextEditingController();
  final TextEditingController imageurl2Controller = TextEditingController();
  final TextEditingController imageurl3Controller = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController itemdesController = TextEditingController();

  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;

  String? get existingUserId => null;
  List<String> selectedServices = [];

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
          decoration: const BoxDecoration(
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

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 210.0, bottom: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UserDataGatherTitle(title: 'Hourly rate*'),
                          TextFormField(
                            controller: hourlyrateController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+$')),
                            ],
                            decoration: InputDecoration(
                              hintText: '00.00',
                              prefixText: '  LKR.',
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
                                return 'Please enter your Hourly rate ';}
                              return null;},),],),),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UserDataGatherTitle(title: 'Your overview*'),
                          TextFormField(
                            controller: bioController,
                            decoration: InputDecoration(
                              hintText: 'Add an overview',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xFF4B4646)
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0x4B4646),
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B4646),),
                            ),
                            maxLines: 8,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your overview';}
                              else if (value.length < 100) {
                                return 'Please enter at least 100 characters';
                              }
                              return null;},),],),),


                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UserDataGatherTitle(title: 'Your skills'),
                          TextFormField(
                            controller: skillsController,
                            decoration: InputDecoration(
                              hintText: 'Enter skills here',
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
                                return 'Please enter your skills';}
                              final skillsList = value.split(',').map((
                                  skill) => skill.trim()).toList();

                              if (skillsList.length < 5) {
                                return 'Please enter up to 5 skills';
                              }
                              return null;},),],),),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UserDataGatherTitle(title: 'Your main services'),
                          TextFormField(
                            controller: servicesController,
                            decoration: InputDecoration(
                              hintText: 'Search for a service',
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
                                return 'Please enter your service ';}
                              return null;},),],),),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0), // Add horizontal padding
                      child: Text('-Selected Services',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B4646), // Adjust the color as needed
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Service 1 and Service 2 side by side
                        GestureDetector(
                          onTap: () => selectService('Logos and branding'),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 26.0),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust the padding
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Color(0xFF4B4646),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Logos and branding',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B4646),),),),),

                        GestureDetector(
                          onTap: () => selectService('Infographics design'),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 0.0),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust the padding
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Color(0xFF4B4646),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Infographics design',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B4646),),),),),],),
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Service 1 and Service 2 side by side
                        GestureDetector(
                          onTap: () => selectService('Website/blog design'),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 26.0),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust the padding
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Color(0xFF4B4646),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Website/blog design',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B4646),),),),),
                        GestureDetector(
                          onTap: () => selectService('Print design'),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 0.0),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust the padding
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Color(0xFF4B4646),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Print design',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B4646),),),),),],),
                    SizedBox(height: 4,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Service 1 and Service 2 side by side
                        GestureDetector(
                          onTap: () => selectService('Podcast cover art design'),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 26.0),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust the padding
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Color(0xFF4B4646),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Podcast cover art design',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B4646),),),),),
                        GestureDetector(
                          onTap: () => selectService('Photoshop design'),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 0.0),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust the padding
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Color(0xFF4B4646),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Photoshop design',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B4646),),),),),],),

                    SizedBox(height: 40,),

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
                              hourlyRate: hourlyrateController.text,
                              bio: bioController.text,
                              sociallink: sociallinkController.text,
                              skills: skillsController.text,
                              services: servicesController.text,

                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileFreelancer3(user: updatedUser),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Save & Next',
                          style: TextStyle(fontSize: 16), // Adjust the font size as needed
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF16056B), // Change the background color
                          onPrimary: Colors.white,    // Change the text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13), // Adjust the border radius as needed
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                        ),
                      ),
                    ),

                    SizedBox(height: 20,)







              ],

              ),
          ),
        ),
      ),
    ),


    );
  }
  void selectService(String serviceName) {
    setState(() {
      selectedServices.add(serviceName);
      servicesController.text =
          selectedServices.join(', '); // Update the text field
    });
  }
}
