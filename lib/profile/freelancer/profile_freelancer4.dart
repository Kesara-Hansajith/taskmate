import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_addphoto.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import '../../constants.dart';
import '../client/profile_client.dart';

class ProfileFreelancer4 extends StatefulWidget {
  final UserModel user;

  const ProfileFreelancer4({required  this.user}) ;

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

  String existingUserId = 'your_existing_user_id';
  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;
  List<File> selectedImages = [];

  get emailRegex => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', caseSensitive: false, multiLine: false,);
  get phoneRegex => RegExp(r'^[0-9]{10}$', caseSensitive: false, multiLine: false,);
  get _urlRegex => RegExp(r"^(https?://)?([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(/\S*)?$");
  final _city1Regex = RegExp(r'^[a-zA-Z]+$');

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
  Future<void> uploadImagesToFirebase() async {
    final storage = firebase_storage.FirebaseStorage.instance;
    final userId = 'your_user_id'; // Replace with your actual user ID

    List<String> uploadedImageUrls = []; // To store the uploaded image URLs

    for (int i = 0; i < selectedImages.length; i++) {
      try {
        final imageFile = selectedImages[i];
        final imageName = path.basename(imageFile.path);
        final storageRef = storage.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

        final uploadTask = storageRef.putFile(imageFile);
        final taskSnapshot = await uploadTask;

        if (taskSnapshot.state == TaskState.success) {
          final imageUrl = await taskSnapshot.ref.getDownloadURL();
          uploadedImageUrls.add(imageUrl);
          print('Image $i uploaded successfully');
        }
      } catch (e) {
        print('Error uploading image $i: $e');
      }
    }
    await saveImageUrlsToFirestore(uploadedImageUrls);
    setState(() {
      selectedImages.clear(); // Clear selectedImages list after upload
    });

      }

  Future<void> saveImageUrlsToFirestore(List<String> imageUrls) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not authenticated.");
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'imageUrls': FieldValue.arrayUnion(imageUrls),
      });

      print('Image URLs saved to Firestore.');
    } catch (e) {
      print('Error saving image URLs to Firestore: $e');
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
              image: AssetImage('images/noise_image.png'),),),
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
                              return 'Please enter your address';}
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
                          maxLength: 150,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your description ';}
                            else if (value.length <= 100){
                              return 'Please enter at least 100 characters';
                            }
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
                          children: selectedImages
                              .map((image) => Image.file(image, height: 80))
                              .toList(),
                        ),],),),
                  SizedBox(height: 100,),

                  Center(
                    child:ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Validated successfully, submit the form
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
                            sociallink: widget.user.sociallink,
                            imageurl1: widget.user.imageurl1,
                            imageurl2: widget.user.imageurl2,
                            imageurl3: widget.user.imageurl3,
                            title: titleController.text,
                            itemdes: itemdesController.text,
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








void selectDate(BuildContext context, TextEditingController birthdayController) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != DateTime.now()) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    birthdayController.text = formattedDate; // Update the text field
  }
}
