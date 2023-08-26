import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer3.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_addphoto.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import '../../constants.dart';
import '../client/profile_client.dart';

class ProfileFreelancer4 extends StatefulWidget {
  //final UserModel user;
  const ProfileFreelancer4({Key? key}) : super(key: key);
  //const ProfileFreelancer4({required  this.user}) ;

  @override

  _ProfileFreelancer4State createState() => _ProfileFreelancer4State();
}

class _ProfileFreelancer4State extends State<ProfileFreelancer4> {
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

  List<File> selectedImages = [];

  String existingUserId = 'your_existing_user_id';
  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;


  get emailRegex => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', caseSensitive: false, multiLine: false,);
  get phoneRegex => RegExp(r'^[0-9]{10}$', caseSensitive: false, multiLine: false,);
  get _urlRegex => RegExp(r"^(https?://)?([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(/\S*)?$");
  final _city1Regex = RegExp(r'^[a-zA-Z]+$');

  get user => existingUserId;

  Future<void> pickImages() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage(
        imageQuality: 85,
      );

      if (pickedFiles != null) {
        setState(() {
          selectedImages.addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  Future<void> savePortfolioItemToFirestore() async {
    try {
      List<String> uploadedImageUrls = [];

      for (int i = 0; i < selectedImages.length; i++) {
        final imageFile = selectedImages[i];
        final imageName = path.basename(imageFile.path);
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('portfolio_images/${DateTime.now().millisecondsSinceEpoch}/$imageName');

        final uploadTask = storageRef.putFile(imageFile);
        final taskSnapshot = await uploadTask;
        if (taskSnapshot.state == firebase_storage.TaskState.success) {
          final imageUrl = await taskSnapshot.ref.getDownloadURL();
          uploadedImageUrls.add(imageUrl);
        }
      }

      await FirebaseFirestore.instance.collection('portfolio_items').add({
        'title': titleController.text,
        'item_description': itemdesController.text,
        'image_urls': selectedImages.map((image) => image.path).toList(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Portfolio item saved to Firestore.');
    } catch (e) {
      print('Error saving portfolio item to Firestore: $e');
    }
  }
  void initState() {
    super.initState();
    Firebase.initializeApp();
    checkAuthentication(); // You can call your authentication check function here
  }
  void checkAuthentication() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Redirect the user to the login page or show an authentication prompt
      // This could be done using Navigator or other methods
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
                  SizedBox(height: 10,),
                  const Center(
                    child: Text('Add Portfolio Item', style: kHeadingTextStyle,),),
                  SizedBox(height: 13,),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UserDataGatherTitle(title: 'Title'),
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            hintText: 'Add a title',
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
                              return 'Please enter your portfolio item';}
                            return null;},),
                        ],),),



                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UserDataGatherTitle(title: 'Item description'),
                        TextFormField(
                          controller: itemdesController,
                          decoration: InputDecoration(
                            hintText: 'Add a portfolio item description',
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
                          maxLines: 8,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your description ';}
                            return null;},),],),),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UserDataGatherTitle(title: 'Upload files'),
                        ElevatedButton(
                          onPressed: pickImages,
                          child: Text('+ Add',
                            style: TextStyle(
                              fontSize: 16,   // Adjust the font size as needed
                              color: Colors.white,   // Adjust the text color
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF16056B), // Change the background color
                            onPrimary: Colors.white,    // Change the text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13), // Adjust the border radius as needed
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),  // Adjust padding as needed
                          ),

                          // Button style properties...
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: selectedImages.map((image) => Container(
                            margin: EdgeInsets.only(bottom: 10), // Add a margin at the bottom
                            child: Image.file(image, height: 80),
                          )).toList(),
                        ),],),),
                  SizedBox(height: 100,),


                  Center(
                    child:ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // Validated successfully, submit the form
                          await savePortfolioItemToFirestore();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Portfolio item saved.'),
                            ),
                          );
                          User? firebaseUser = FirebaseAuth.instance.currentUser;

                          Navigator.pop(context);

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProfileFreelancer2(user: user),
                          //   ),
                          // );


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
                  SizedBox(height: 20,)






                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}










