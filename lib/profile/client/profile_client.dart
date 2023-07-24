import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:taskmate/profile/client/data_details_screen.dart';
import 'package:taskmate/profile/client/data_display_screen_client.dart';
import 'package:taskmate/profile/client/upload_profile_image1.dart';
import 'package:taskmate/profile/client/user_model1.dart';
import 'dart:io';

import 'package:taskmate/profile/client/user_repository1.dart';





class ProfileClient extends StatefulWidget {
  const ProfileClient({Key? key}) : super(key: key);

  @override
  _ProfileFreelancerState createState() => _ProfileFreelancerState();
}

class _ProfileFreelancerState extends State<ProfileClient> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();




  String? profileImageUrl;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;

  get emailRegex => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
    multiLine: false,
  );

  get phoneRegex => RegExp(
    r'^[0-9]{10}$', // Assumes the phone number should be exactly 10 digits.
    caseSensitive: false,
    multiLine: false,
  );

  get _urlRegex => RegExp(
      r"^(https?://)?([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(/\S*)?$");



  // void updateData() {
  //   if (formKey.currentState!.validate()) {
  //     // Validated successfully, update the data
  //     // Update the data using the values in the text controllers
  //     // You can use the values to update the user's profile, save it to a database, etc.
  //
  //     setState(() {
  //       dataSubmitted = true; // Set the flag to indicate data has been submitted
  //     });
  //   }
  // }

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final String downloadUrl = await uploadProfileImage1(imageFile);

      setState(() {
        profileImageUrl = downloadUrl;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Optional: Set elevation to 0 to remove the shadow
        title: Center(
          child: Text(
            'Client Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, // Set the desired text color
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        // Other AppBar properties if needed
      ),



      body: Container(
        margin: EdgeInsets.all(10), // Add margin to the container,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/noise_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [

                              GestureDetector(
                                onTap: _pickProfileImage,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if (profileImageUrl != null)
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(profileImageUrl!),
                                          radius: 75,
                                        ),
                                      if (profileImageUrl == null)
                                        Icon(
                                          Icons.camera_alt,
                                          size: 50,
                                          color: Colors.grey[500],
                                        ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                          child: IconButton(
                                            onPressed: _pickProfileImage,
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),



                              if (profileImageUrl != null)
                                Center(
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 75,
                                        backgroundImage: NetworkImage(profileImageUrl!),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                          child: IconButton(
                                            onPressed: _pickProfileImage,
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(

                        ),
                        SizedBox(height: 20),

                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: firstNameController,
                                      decoration: InputDecoration(
                                        labelText: 'First Name',
                                        prefixIcon: Icon(LineAwesomeIcons.user),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xF4F7F9),
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your first name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10), // Add some spacing between the fields
                                  Expanded(
                                    child: TextFormField(
                                      controller: lastNameController,
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
                                        prefixIcon: Icon(LineAwesomeIcons.user),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xF4F7F9),
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your last name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children : [
                                TextFormField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    label: Text('Address'),
                                    prefixIcon: Icon(LineAwesomeIcons.home),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xF4F7F9),
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your address ';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 07),



                                Column(
                                  children: [
                                    SizedBox(height: 06), // Add some vertical spacing
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: zipCodeController,
                                            decoration: InputDecoration(
                                              label: Text('Zip Code'),
                                              prefixIcon: Icon(LineAwesomeIcons.address_book),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xF4F7F9),
                                              labelStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your zip code';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),

                                        SizedBox(width: 10), // Add some spacing between fields
                                        Expanded(
                                          child: TextFormField(
                                            controller: provinceController,
                                            decoration: InputDecoration(
                                              label: Text('Province'),
                                              prefixIcon: Icon(LineAwesomeIcons.globe),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xF4F7F9),
                                              labelStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your province';
                                              }
                                              return null;
                                            },
                                            onTap: () async {
                                              // Open province selection dialog
                                              final selectedValue = await showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Select Province'),
                                                    content: DropdownButtonFormField<String>(
                                                      value: selectedProvince,
                                                      items: [
                                                        DropdownMenuItem(
                                                          value: 'Central Province',
                                                          child: Text('Central Province'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Eastern Province',
                                                          child: Text('Eastern province'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'North Central Province',
                                                          child: Text('North Central Province'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'North Western Province',
                                                          child: Text('North Western Province'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Northern Province',
                                                          child: Text('Northern Province'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Sabaragamuwa Province',
                                                          child: Text('Sabaragamuwa Province'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Southern Province',
                                                          child: Text('Southern Province'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Uva Province',
                                                          child: Text('Uva Province'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Western Province',
                                                          child: Text('Western Province'),
                                                        ),
                                                        // Add more provinces as needed
                                                      ],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedProvince = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        contentPadding: EdgeInsets.symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 8.0,
                                                        ),
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context, selectedProvince);
                                                        },
                                                        child: Text('OK'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              if (selectedValue != null) {
                                                provinceController.text = selectedValue;
                                              }
                                            },
                                          ),
                                        ),


                                        SizedBox(width: 10), // Add some spacing between fields
                                        Expanded(
                                          child: TextFormField(
                                            controller: cityController,
                                            decoration: InputDecoration(
                                              label: Text('City'),
                                              prefixIcon: Icon(LineAwesomeIcons.city),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xF4F7F9),
                                              labelStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your city';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              label: Text('Email'),
                                              prefixIcon: Icon(LineAwesomeIcons.envelope),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xF4F7F9),
                                              labelStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your email';
                                              } else if (!emailRegex.hasMatch(value)) {
                                                return 'Please enter a valid email address';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),


                                        SizedBox(width: 10), // Add some spacing between fields
                                        Expanded(
                                          child: TextFormField(
                                            controller: phoneController,
                                            decoration: InputDecoration(
                                              label: Text('Phone Number'),
                                              prefixIcon: Icon(LineAwesomeIcons.phone),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xF4F7F9),
                                              labelStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your phone number';
                                              } else if (!phoneRegex.hasMatch(value)) {
                                                return 'Please enter a valid 10-digit phone number';
                                              }

                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),




                                    TextFormField(
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        label: Text('Password'),
                                        prefixIcon: Icon(Icons.fingerprint),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xF4F7F9),
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      obscureText: true, // Hide the password text
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: 50),



                                    ElevatedButton(
                                      onPressed: //profileImageUrl == null || profileImageUrl!.isEmpty
                                      //? null
                                      //:
                                          () {
                                        //updateData();
                                        if (formKey.currentState!.validate()) {
                                          // Validated successfully, submit the form
                                          final client = UserModel1(
                                            email: emailController.text.trim(),
                                            password: passwordController.text.trim(),
                                            firstName: firstNameController.text.trim(),
                                            lastName: lastNameController.text.trim(),
                                            address: addressController.text.trim(),
                                            zipcode: zipCodeController.text.trim(),
                                            province: provinceController.text.trim(),
                                            city: cityController.text.trim(),
                                            phoneNo: phoneController.text.trim(),
                                            profilePhotoUrl: profileImageUrl,
                                          );

                                          UserRepository1.instance.createUser(client);


                                          // Clear the text field values
                                          // firstNameController.clear();
                                          // lastNameController.clear();
                                          // addressController.clear();
                                          // zipCodeController.clear();
                                          // provinceController.clear();
                                          // cityController.clear();
                                          // emailController.clear();
                                          // phoneController.clear();
                                          // passwordController.clear();

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Success'),
                                                content: Text('Your account is successfully created.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                        context,

                                                          MaterialPageRoute(
                                                          builder: (context) => DataDetailsScreenClient(client: client),
                                                          ),// Pass the UserModel1 object to the DataDetailsScreenClient
                                                      );
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          // Navigate to the DataDisplayScreen

                                          // Navigator.push(
                                          //   context,
                                          //  MaterialPageRoute(builder: (context) => DataDetailsScreenClient(client: client)),
                                          // );




                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //     builder: (context) => ProfilePage1(user: user),
                                          // // Clear the profile image URL
                                          //     ),
                                          // );
                                        }
                                      },

                                      child: SizedBox(
                                        width: 200, // Adjust the width as needed
                                        height: 50, // Adjust the height as needed

                                        child: Center(
                                          child: Text(
                                            'Submit',
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),

                                          ),

                                        ),

                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
