import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/messaging/Chatscreen.dart';
import 'package:taskmate/profile/freelancer/EditFreelancerProfile.dart';
import 'package:taskmate/constants.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';

class DataDetailsScreenFreelancer extends StatefulWidget {
  // late final UserModel user;
  // final String? profileImageUrl;

  // DataDetailsScreenFreelancer({
  //   // required this.user,
  //   // this.profileImageUrl,
  // });

  @override
  _DataDetailsScreenFreelancerState createState() =>
      _DataDetailsScreenFreelancerState();
}

class _DataDetailsScreenFreelancerState
    extends State<DataDetailsScreenFreelancer> {
  final double coverHeight = 220;
  final double profileHeight = 134;

  Widget buildCoverImage() {
    return Stack(
      children: [
        Container(
          child: Container(
            color: kDeepBlueColor,
            child:
                // widget.profileImageUrl != null
                //     ? Image.network(
                //         widget.profileImageUrl!,
                //         fit: BoxFit.cover,
                //         width: double.infinity,
                //         height: coverHeight,
                //       )
                //     :
                Placeholder(),
            // You can replace Placeholder with a loading indicator
          ),
        ),
      ],
    );
  }

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundImage: const AssetImage('images/noise_image.webp'),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: profileHeight / 2 - 6,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  // widget.profileImageUrl ??
                  ''),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/noise_image.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  buildCoverImage(),
                  Positioned(
                    top: top,
                    left: (screenWidth - profileHeight) / 2,
                    child: buildProfileImage(),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Center(
                child: Column(
                  children: [
                    Text(
                      '${'widget.user.firstNam'} ${'widget.user.lastName'}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(
                        height:
                            5), // Add some spacing between the name and the level
                    Text(
                      'Top Level Freelancer',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5696FA),
                      ),
                    ),
                    DarkMainButton(
                        title: 'Message',
                        process: () {
                          Chatscreen();
                        })
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                child: SizedBox(
                  width: 500, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'ProfessionalRole: ${'widget.user.professionalRole'}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(13.0, 2.0, 10.0, 10.0),
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Hourly Rate: ${'widget.user.hourlyRate'}.00 LKR/hour',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(4.0, 0, 0.0, 0.0),
                child: SizedBox(
                  width: 390, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Bio: ${'widget.user.bio'}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              Container(
                // Adjust this value for desired alignment
                child: Center(
                  child: SizedBox(
                    width: 360,
                    child: Divider(
                      color: Color(0xFF969595),
                      thickness: 1.2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: Text(
                  'Portfolio',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              SingleChildScrollView(
                // Wrap this part
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(35.0, 10.0, 10.0, 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Get the current user
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          final User? firebaseUser = _auth.currentUser;

                          if (firebaseUser != null) {
                            final String userUid = firebaseUser.uid;

                            // Create a reference to the user's document
                            final DocumentReference userDocRef =
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(userUid);

                            // Fetch document with ID '1' from the subcollection 'portfolio_items'
                            userDocRef
                                .collection('portfolio_items')
                                .doc('1') // Use '1' as the document ID
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot.exists) {
                                final Map<String, dynamic>? data =
                                    documentSnapshot.data()
                                        as Map<String, dynamic>?;
                                final String title = data?['title'] ?? '';
                                final String itemDescription =
                                    data?['item_description'] ?? '';
                                final List<dynamic>? imageUrls =
                                    data?['image_urls'];

                                // Check if imageUrls is not empty
                                if (imageUrls != null && imageUrls.isNotEmpty) {
                                  // Create a list of images for this portfolio item
                                  List<Widget> images = [];

                                  // Loop through the image URLs and add them to the list
                                  for (var imageUrl in imageUrls) {
                                    images.add(
                                      Image.network(
                                        imageUrl,
                                        width:
                                            100, // Adjust the width as needed
                                        height:
                                            100, // Adjust the height as needed
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }

                                  // Display the portfolio item in a dialog
                                  List<Widget> imageRows = [];

                                  // Calculate the number of images per row
                                  int imagesPerRow =
                                      2; // You can change this value to the desired number

                                  // Create rows of images with spacing
                                  for (int i = 0;
                                      i < images.length;
                                      i += imagesPerRow) {
                                    List<Widget> rowChildren = [];

                                    // Add images to the current row
                                    for (int j = i;
                                        j < i + imagesPerRow &&
                                            j < images.length;
                                        j++) {
                                      rowChildren.add(
                                        Column(
                                          children: [
                                            images[j],
                                            SizedBox(height: 8.0),
                                          ],
                                        ),
                                      );

                                      if (j < i + imagesPerRow - 1) {
                                        // Add spacing between images in the same row
                                        rowChildren.add(
                                          SizedBox(width: 16.0),
                                        );
                                      }
                                    }

                                    // Create a row with images and spacing
                                    imageRows.add(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: rowChildren,
                                      ),
                                    );
                                  }

                                  // Display the portfolio item in a dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Container(
                                          width:
                                              600, // Adjust the width as needed
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'images/noise_image.webp'), // Add your background image here
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                title,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                  'Description: $itemDescription'),
                                              SizedBox(height: 16.0),
                                              // Display the rows of images
                                              Column(
                                                children: imageRows,
                                              ),
                                              SizedBox(height: 16.0),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      kDeepBlueColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: const <Widget>[
                                                      Text(
                                                        'Close',
                                                        style: TextStyle(
                                                          color:
                                                              kBrilliantWhite,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                // Handle the case where the document with ID '1' does not exist
                              }
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                                // You can set a placeholder image here
                                // This will be shown until the actual image is loaded
                                // You can also check if 'imageUrls' is not empty and use the first URL
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/taskmate_logo_light.webp', // Replace with your image URL
                                      width: 80, // Adjust the width as needed
                                      height:
                                          100, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    8.0), // Add spacing between the box and text
                            Text(
                              'Project 1',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35.0, 10.0, 10.0, 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Get the current user
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          final User? firebaseUser = _auth.currentUser;

                          if (firebaseUser != null) {
                            final String userUid = firebaseUser.uid;

                            // Create a reference to the user's document
                            final DocumentReference userDocRef =
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(userUid);

                            // Fetch document with ID '1' from the subcollection 'portfolio_items'
                            userDocRef
                                .collection('portfolio_items')
                                .doc('2') // Use '2' as the document ID
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot.exists) {
                                final Map<String, dynamic>? data =
                                    documentSnapshot.data()
                                        as Map<String, dynamic>?;
                                final String title = data?['title'] ?? '';
                                final String itemDescription =
                                    data?['item_description'] ?? '';
                                final List<dynamic>? imageUrls =
                                    data?['image_urls'];

                                // Check if imageUrls is not empty
                                if (imageUrls != null && imageUrls.isNotEmpty) {
                                  // Create a list of images for this portfolio item
                                  List<Widget> images = [];

                                  // Loop through the image URLs and add them to the list
                                  for (var imageUrl in imageUrls) {
                                    images.add(
                                      Image.network(
                                        imageUrl,
                                        width:
                                            100, // Adjust the width as needed
                                        height:
                                            100, // Adjust the height as needed
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }

                                  // Display the portfolio item in a dialog
                                  List<Widget> imageRows = [];

                                  // Calculate the number of images per row
                                  int imagesPerRow =
                                      2; // You can change this value to the desired number

                                  // Create rows of images with spacing
                                  for (int i = 0;
                                      i < images.length;
                                      i += imagesPerRow) {
                                    List<Widget> rowChildren = [];

                                    // Add images to the current row
                                    for (int j = i;
                                        j < i + imagesPerRow &&
                                            j < images.length;
                                        j++) {
                                      rowChildren.add(
                                        Column(
                                          children: [
                                            images[j],
                                            SizedBox(height: 8.0),
                                          ],
                                        ),
                                      );

                                      if (j < i + imagesPerRow - 1) {
                                        // Add spacing between images in the same row
                                        rowChildren.add(
                                          SizedBox(width: 16.0),
                                        );
                                      }
                                    }

                                    // Create a row with images and spacing
                                    imageRows.add(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: rowChildren,
                                      ),
                                    );
                                  }

                                  // Display the portfolio item in a dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Container(
                                          width:
                                              600, // Adjust the width as needed
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'images/noise_image.webp'), // Add your background image here
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                title,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                  'Description: $itemDescription'),
                                              SizedBox(height: 16.0),
                                              // Display the rows of images
                                              Column(
                                                children: imageRows,
                                              ),
                                              SizedBox(height: 16.0),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      kDeepBlueColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: const <Widget>[
                                                      Text(
                                                        'Close',
                                                        style: TextStyle(
                                                          color:
                                                              kBrilliantWhite,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                // Handle the case where the document with ID '1' does not exist
                              }
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                                // You can set a placeholder image here
                                // This will be shown until the actual image is loaded
                                // You can also check if 'imageUrls' is not empty and use the first URL
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/taskmate_logo_light.webp', // Replace with your image URL
                                      width: 80, // Adjust the width as needed
                                      height:
                                          100, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    8.0), // Add spacing between the box and text
                            Text(
                              'Project 2',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35.0, 10.0, 10.0, 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Get the current user
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          final User? firebaseUser = _auth.currentUser;

                          if (firebaseUser != null) {
                            final String userUid = firebaseUser.uid;

                            // Create a reference to the user's document
                            final DocumentReference userDocRef =
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(userUid);

                            // Fetch document with ID '1' from the subcollection 'portfolio_items'
                            userDocRef
                                .collection('portfolio_items')
                                .doc('3') // Use '3' as the document ID
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot.exists) {
                                final Map<String, dynamic>? data =
                                    documentSnapshot.data()
                                        as Map<String, dynamic>?;
                                final String title = data?['title'] ?? '';
                                final String itemDescription =
                                    data?['item_description'] ?? '';
                                final List<dynamic>? imageUrls =
                                    data?['image_urls'];

                                // Check if imageUrls is not empty
                                if (imageUrls != null && imageUrls.isNotEmpty) {
                                  // Create a list of images for this portfolio item
                                  List<Widget> images = [];

                                  // Loop through the image URLs and add them to the list
                                  for (var imageUrl in imageUrls) {
                                    images.add(
                                      Image.network(
                                        imageUrl,
                                        width:
                                            100, // Adjust the width as needed
                                        height:
                                            100, // Adjust the height as needed
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }

                                  // Display the portfolio item in a dialog
                                  List<Widget> imageRows = [];

                                  // Calculate the number of images per row
                                  int imagesPerRow =
                                      2; // You can change this value to the desired number

                                  // Create rows of images with spacing
                                  for (int i = 0;
                                      i < images.length;
                                      i += imagesPerRow) {
                                    List<Widget> rowChildren = [];

                                    // Add images to the current row
                                    for (int j = i;
                                        j < i + imagesPerRow &&
                                            j < images.length;
                                        j++) {
                                      rowChildren.add(
                                        Column(
                                          children: [
                                            images[j],
                                            SizedBox(height: 8.0),
                                          ],
                                        ),
                                      );

                                      if (j < i + imagesPerRow - 1) {
                                        // Add spacing between images in the same row
                                        rowChildren.add(
                                          SizedBox(width: 16.0),
                                        );
                                      }
                                    }

                                    // Create a row with images and spacing
                                    imageRows.add(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: rowChildren,
                                      ),
                                    );
                                  }

                                  // Display the portfolio item in a dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Container(
                                          width:
                                              600, // Adjust the width as needed
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'images/noise_image.webp'), // Add your background image here
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                title,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                  'Description: $itemDescription'),
                                              SizedBox(height: 16.0),
                                              // Display the rows of images
                                              Column(
                                                children: imageRows,
                                              ),
                                              SizedBox(height: 16.0),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      kDeepBlueColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: const <Widget>[
                                                      Text(
                                                        'Close',
                                                        style: TextStyle(
                                                          color:
                                                              kBrilliantWhite,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                // Handle the case where the document with ID '1' does not exist
                              }
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                                // You can set a placeholder image here
                                // This will be shown until the actual image is loaded
                                // You can also check if 'imageUrls' is not empty and use the first URL
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/taskmate_logo_light.webp', // Replace with your image URL
                                      width: 80, // Adjust the width as needed
                                      height:
                                          100, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    8.0), // Add spacing between the box and text
                            Text(
                              'Project 3',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35.0, 10.0, 10.0, 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Get the current user
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          final User? firebaseUser = _auth.currentUser;

                          if (firebaseUser != null) {
                            final String userUid = firebaseUser.uid;

                            // Create a reference to the user's document
                            final DocumentReference userDocRef =
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(userUid);

                            // Fetch document with ID '1' from the subcollection 'portfolio_items'
                            userDocRef
                                .collection('portfolio_items')
                                .doc('4') // Use '4' as the document ID
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot.exists) {
                                final Map<String, dynamic>? data =
                                    documentSnapshot.data()
                                        as Map<String, dynamic>?;
                                final String title = data?['title'] ?? '';
                                final String itemDescription =
                                    data?['item_description'] ?? '';
                                final List<dynamic>? imageUrls =
                                    data?['image_urls'];

                                // Check if imageUrls is not empty
                                if (imageUrls != null && imageUrls.isNotEmpty) {
                                  // Create a list of images for this portfolio item
                                  List<Widget> images = [];

                                  // Loop through the image URLs and add them to the list
                                  for (var imageUrl in imageUrls) {
                                    images.add(
                                      Image.network(
                                        imageUrl,
                                        width:
                                            100, // Adjust the width as needed
                                        height:
                                            100, // Adjust the height as needed
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }

                                  // Display the portfolio item in a dialog
                                  List<Widget> imageRows = [];

                                  // Calculate the number of images per row
                                  int imagesPerRow =
                                      2; // You can change this value to the desired number

                                  // Create rows of images with spacing
                                  for (int i = 0;
                                      i < images.length;
                                      i += imagesPerRow) {
                                    List<Widget> rowChildren = [];

                                    // Add images to the current row
                                    for (int j = i;
                                        j < i + imagesPerRow &&
                                            j < images.length;
                                        j++) {
                                      rowChildren.add(
                                        Column(
                                          children: [
                                            images[j],
                                            SizedBox(height: 8.0),
                                          ],
                                        ),
                                      );

                                      if (j < i + imagesPerRow - 1) {
                                        // Add spacing between images in the same row
                                        rowChildren.add(
                                          SizedBox(width: 16.0),
                                        );
                                      }
                                    }

                                    // Create a row with images and spacing
                                    imageRows.add(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: rowChildren,
                                      ),
                                    );
                                  }

                                  // Display the portfolio item in a dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Container(
                                          width:
                                              600, // Adjust the width as needed
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'images/noise_image.webp'), // Add your background image here
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                title,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                  'Description: $itemDescription'),

                                              SizedBox(height: 16.0),
                                              // Display the rows of images
                                              Column(
                                                children: imageRows,
                                              ),
                                              SizedBox(height: 16.0),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      kDeepBlueColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: const <Widget>[
                                                      Text(
                                                        'Close',
                                                        style: TextStyle(
                                                          color:
                                                              kBrilliantWhite,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                // Handle the case where the document with ID '1' does not exist
                              }
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                                // You can set a placeholder image here
                                // This will be shown until the actual image is loaded
                                // You can also check if 'imageUrls' is not empty and use the first URL
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/taskmate_logo_light.webp', // Replace with your image URL
                                      width: 80, // Adjust the width as needed
                                      height:
                                          100, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    8.0), // Add spacing between the box and text
                            Text(
                              'Project 4',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1),
              Container(
                // Adjust this value for desired alignment
                child: Center(
                  child: SizedBox(
                    width: 360,
                    child: Divider(
                      color: Color(0xFF969595),
                      thickness: 1.2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(55.0, 0, 0.0, 0.0),
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Review Part Under Construction',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kAmberColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 0, 55.0, 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => EditFreelancerProfile(
                            // user: widget.user,
                            // profileImageUrl: widget.profileImageUrl,
                            ),
                      ),
                    )
                        .then((updatedUser) {
                      if (updatedUser != null) {
                        setState(() {
                          // Update the widget's user data with the updatedUser data
                          // widget.user = updatedUser;
                        });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDeepBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: kBrilliantWhite,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
