import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io'; // Add this import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmate/profile/freelancer/data_details_screen_freelancer.dart';
import 'package:taskmate/profile/freelancer/profile_freelancer_4.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';
import 'package:path/path.dart' as path;


class EditFreelancerProfile extends StatefulWidget {
  final UserModel user;
  final String? profileImageUrl;

  EditFreelancerProfile({required this.user,this.profileImageUrl});

  @override
  _EditFreelancerProfileState createState() => _EditFreelancerProfileState();
}

class _EditFreelancerProfileState extends State<EditFreelancerProfile> {
  final TextEditingController bioController = TextEditingController();
  final TextEditingController professionalRoleController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();

  String? profileImageUrl;

  final double profileHeight = 134; // Store the updated profile image URL here


  @override
  void initState() {
    super.initState();
    // Initialize the text fields with the existing user data
    bioController.text = widget.user.bio ?? ''; // Use user's bio or an empty string if it's null
    professionalRoleController.text = widget.user.professionalRole ?? ''; // Use user's role or an empty string if it's null
    hourlyRateController.text = widget.user.hourlyRate ?? '';
    profileImageUrl = widget.user.profilePhotoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Freelancer Profile"),
      ),
    body: SingleChildScrollView( // Wrap your entire content with SingleChildScrollView
    child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              CircleAvatar(
                radius: profileHeight / 2 - 6,
                backgroundColor: Colors.white,
                backgroundImage: widget.profileImageUrl != null
                    ? NetworkImage(widget.profileImageUrl!)
                    : AssetImage('images/iconamoon_profile-circle-thin.png') as ImageProvider<Object>,
              ),

              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _updateProfileImage(); // Call the method to update the image
                },
                child: Text("Change Profile Image"),
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: bioController,
                decoration: InputDecoration(labelText: "Bio"),),
              TextFormField(
                controller: hourlyRateController,
                decoration: InputDecoration(labelText: "Hourly Rate"),),
              TextFormField(
                controller: professionalRoleController,
                decoration: InputDecoration(labelText: "Professional Role"),),
              SizedBox(height: 10),
              Container(
                // Adjust this value for desired alignment
                child: Center(
                  child: SizedBox(
                    width: 360,
                    child: Divider(
                      color: Color(0xFF969595),
                      thickness: 1.2,),),),),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: Text(
                  'Portfolio',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,),),),
          SingleChildScrollView( // Wrap this part
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
                          final DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userUid);
                          final DocumentReference portfolioItemDocRef = userDocRef.collection('portfolio_items').doc('1');

                          // Show a confirmation dialog before deleting
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Portfolio Item'),
                                content: Text('Are you sure you want to delete this project 1'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the confirmation dialog
                                    },
                                    child: Text('Cancel'),),
                                  TextButton(
                                    onPressed: () async {
                                      // Delete the document
                                      await portfolioItemDocRef.delete();
                                      Navigator.of(context).pop(); // Close the confirmation dialog
                                      Navigator.of(context).pop(); // Close the portfolio item dialog
                                      // Now, navigate to "ProfileFreelancer4"
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                      );
                                    },
                                    child: Text('Delete'),),],);
                            },);

                          // Fetch document with ID '1' from the subcollection 'portfolio_items'
                          userDocRef
                              .collection('portfolio_items')
                              .doc('1') // Use '1' as the document ID
                              .get()
                              .then((DocumentSnapshot documentSnapshot) {
                            if (documentSnapshot.exists) {
                              final Map<String, dynamic>? data =
                              documentSnapshot.data() as Map<String, dynamic>?;
                              final String title = data?['title'] ?? '';
                              final String itemDescription = data?['item_description'] ?? '';
                              final List<dynamic>? imageUrls = data?['image_urls'];

                              // Check if imageUrls is not empty
                              if (imageUrls != null && imageUrls.isNotEmpty) {
                                // Create a list of images for this portfolio item
                                List<Widget> images = [];

                                // Loop through the image URLs and add them to the list
                                for (var imageUrl in imageUrls) {
                                  images.add(
                                    Image.network(
                                      imageUrl,
                                      width: 100, // Adjust the width as needed
                                      height: 100, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }

                                // Display the portfolio item in a dialog
                                List<Widget> imageRows = [];

                                // Calculate the number of images per row
                                int imagesPerRow = 2; // You can change this value to the desired number

                                // Create rows of images with spacing
                                for (int i = 0; i < images.length; i += imagesPerRow) {
                                  List<Widget> rowChildren = [];

                                  // Add images to the current row
                                  for (int j = i; j < i + imagesPerRow && j < images.length; j++) {
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
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                        width: 600, // Adjust the width as needed
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              title,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text('Description: $itemDescription'),
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
                                              child: Text('Close'),
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
                              border: Border.all(color: Colors.white, width: 2.0),
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
                                    height: 100, // Adjust the height as needed
                                    fit: BoxFit.cover,
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0), // Add spacing between the box and text
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
                          final DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userUid);
                          final DocumentReference portfolioItemDocRef = userDocRef.collection('portfolio_items').doc('2');

                          // Show a confirmation dialog before deleting
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Portfolio Item'),
                                content: Text('Are you sure you want to delete this project 2'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the confirmation dialog
                                    },
                                    child: Text('Cancel'),),
                                  TextButton(
                                    onPressed: () async {
                                      // Delete the document
                                      await portfolioItemDocRef.delete();
                                      Navigator.of(context).pop(); // Close the confirmation dialog
                                      Navigator.of(context).pop(); // Close the portfolio item dialog
                                      // Now, navigate to "ProfileFreelancer4"
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                      );
                                    },
                                    child: Text('Delete'),),],);
                            },);

                          // Fetch document with ID '1' from the subcollection 'portfolio_items'
                          userDocRef
                              .collection('portfolio_items')
                              .doc('2') // Use '2' as the document ID
                              .get()
                              .then((DocumentSnapshot documentSnapshot) {
                            if (documentSnapshot.exists) {
                              final Map<String, dynamic>? data =
                              documentSnapshot.data() as Map<String, dynamic>?;
                              final String title = data?['title'] ?? '';
                              final String itemDescription = data?['item_description'] ?? '';
                              final List<dynamic>? imageUrls = data?['image_urls'];

                              // Check if imageUrls is not empty
                              if (imageUrls != null && imageUrls.isNotEmpty) {
                                // Create a list of images for this portfolio item
                                List<Widget> images = [];

                                // Loop through the image URLs and add them to the list
                                for (var imageUrl in imageUrls) {
                                  images.add(
                                    Image.network(
                                      imageUrl,
                                      width: 100, // Adjust the width as needed
                                      height: 100, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }

                                // Display the portfolio item in a dialog
                                List<Widget> imageRows = [];

                                // Calculate the number of images per row
                                int imagesPerRow = 2; // You can change this value to the desired number

                                // Create rows of images with spacing
                                for (int i = 0; i < images.length; i += imagesPerRow) {
                                  List<Widget> rowChildren = [];

                                  // Add images to the current row
                                  for (int j = i; j < i + imagesPerRow && j < images.length; j++) {
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
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                        width: 600, // Adjust the width as needed
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              title,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text('Description: $itemDescription'),
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
                                              child: Text('Close'),
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
                              border: Border.all(color: Colors.white, width: 2.0),
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
                                    height: 100, // Adjust the height as needed
                                    fit: BoxFit.cover,
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0), // Add spacing between the box and text
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
                          final DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userUid);
                          final DocumentReference portfolioItemDocRef = userDocRef.collection('portfolio_items').doc('3');

                          // Show a confirmation dialog before deleting
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Portfolio Item'),
                                content: Text('Are you sure you want to delete this project 3'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the confirmation dialog
                                    },
                                    child: Text('Cancel'),),
                                  TextButton(
                                    onPressed: () async {
                                      // Delete the document
                                      await portfolioItemDocRef.delete();
                                      Navigator.of(context).pop(); // Close the confirmation dialog
                                      Navigator.of(context).pop(); // Close the portfolio item dialog
                                      // Now, navigate to "ProfileFreelancer4"
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                      );
                                    },
                                    child: Text('Delete'),),],);
                            },);

                          // Fetch document with ID '1' from the subcollection 'portfolio_items'
                          userDocRef
                              .collection('portfolio_items')
                              .doc('3') // Use '3' as the document ID
                              .get()
                              .then((DocumentSnapshot documentSnapshot) {
                            if (documentSnapshot.exists) {
                              final Map<String, dynamic>? data =
                              documentSnapshot.data() as Map<String, dynamic>?;
                              final String title = data?['title'] ?? '';
                              final String itemDescription = data?['item_description'] ?? '';
                              final List<dynamic>? imageUrls = data?['image_urls'];

                              // Check if imageUrls is not empty
                              if (imageUrls != null && imageUrls.isNotEmpty) {
                                // Create a list of images for this portfolio item
                                List<Widget> images = [];

                                // Loop through the image URLs and add them to the list
                                for (var imageUrl in imageUrls) {
                                  images.add(
                                    Image.network(
                                      imageUrl,
                                      width: 100, // Adjust the width as needed
                                      height: 100, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }

                                // Display the portfolio item in a dialog
                                List<Widget> imageRows = [];

                                // Calculate the number of images per row
                                int imagesPerRow = 2; // You can change this value to the desired number

                                // Create rows of images with spacing
                                for (int i = 0; i < images.length; i += imagesPerRow) {
                                  List<Widget> rowChildren = [];

                                  // Add images to the current row
                                  for (int j = i; j < i + imagesPerRow && j < images.length; j++) {
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
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                        width: 600, // Adjust the width as needed
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              title,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text('Description: $itemDescription'),
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
                                              child: Text('Close'),
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
                              border: Border.all(color: Colors.white, width: 2.0),
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
                                    height: 100, // Adjust the height as needed
                                    fit: BoxFit.cover,
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0), // Add spacing between the box and text
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
                          final DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userUid);
                          final DocumentReference portfolioItemDocRef = userDocRef.collection('portfolio_items').doc('4');

                          // Show a confirmation dialog before deleting
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Portfolio Item'),
                                content: Text('Are you sure you want to delete this project 4'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the confirmation dialog
                                    },
                                    child: Text('Cancel'),),
                                  TextButton(
                                    onPressed: () async {
                                      // Delete the document
                                      await portfolioItemDocRef.delete();
                                      Navigator.of(context).pop(); // Close the confirmation dialog
                                      Navigator.of(context).pop(); // Close the portfolio item dialog
                                      // Now, navigate to "ProfileFreelancer4"
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProfileFreelancer4()),
                                      );
                                    },
                                    child: Text('Delete'),),],);
                            },);

                          // Fetch document with ID '1' from the subcollection 'portfolio_items'
                          userDocRef
                              .collection('portfolio_items')
                              .doc('4') // Use '4' as the document ID
                              .get()
                              .then((DocumentSnapshot documentSnapshot) {
                            if (documentSnapshot.exists) {
                              final Map<String, dynamic>? data =
                              documentSnapshot.data() as Map<String, dynamic>?;
                              final String title = data?['title'] ?? '';
                              final String itemDescription = data?['item_description'] ?? '';
                              final List<dynamic>? imageUrls = data?['image_urls'];

                              // Check if imageUrls is not empty
                              if (imageUrls != null && imageUrls.isNotEmpty) {
                                // Create a list of images for this portfolio item
                                List<Widget> images = [];

                                // Loop through the image URLs and add them to the list
                                for (var imageUrl in imageUrls) {
                                  images.add(
                                    Image.network(
                                      imageUrl,
                                      width: 100, // Adjust the width as needed
                                      height: 100, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }

                                // Display the portfolio item in a dialog
                                List<Widget> imageRows = [];

                                // Calculate the number of images per row
                                int imagesPerRow = 2; // You can change this value to the desired number

                                // Create rows of images with spacing
                                for (int i = 0; i < images.length; i += imagesPerRow) {
                                  List<Widget> rowChildren = [];

                                  // Add images to the current row
                                  for (int j = i; j < i + imagesPerRow && j < images.length; j++) {
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
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                        width: 600, // Adjust the width as needed
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              title,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text('Description: $itemDescription'),
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
                                              child: Text('Close'),
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
                              border: Border.all(color: Colors.white, width: 2.0),
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
                                    height: 100, // Adjust the height as needed
                                    fit: BoxFit.cover,
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0), // Add spacing between the box and text
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
                ],),),
          // Display existing user details in non-editable form fields
              SizedBox(height: 1),
              Container(
                // Adjust this value for desired alignment
                child: Center(
                  child: SizedBox(
                    width: 360,
                    child: Divider(
                      color: Color(0xFF969595),
                      thickness: 1.2,),),),),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Update Firestore data with the new bio and professional role
                  await updateFirestoreData();
                  final updatedUser = UserModel(
                    bio: bioController.text,
                    professionalRole: professionalRoleController.text,
                    hourlyRate: hourlyRateController.text,
                    profilePhotoUrl: profileImageUrl,
                    firstName: widget.user.firstName, // Keep existing first name
                    lastName: widget.user.lastName,
                    email: '',
                    password: '',
                    address: '',
                    zipcode: '',
                    birthday: '', gender: '', province: '',
                    city: '', street: '', skills: '', services: '', sociallink: '', phoneNo: '',
                    // ... other user data fields ...
                  );


                  // Navigate back to the previous screen and pass the updated user data
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DataDetailsScreenFreelancer(user: updatedUser,profileImageUrl: profileImageUrl,),),);},
                child: Text("Save"),),],),),),),);}

  Future<void> updateFirestoreData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      final String userUid = firebaseUser.uid;

      try {
        await FirebaseFirestore.instance.collection('Users').doc(userUid).update(
          {
            'bio': bioController.text, // Updated bio
            'professionalRole': professionalRoleController.text, // Updated professional role
            'hourlyRate': hourlyRateController.text,
            'profilePhotoUrl': profileImageUrl,
          },
        );
      } catch (e) {
        // Handle errors, e.g., show an error message to the user
        print("Error updating profile: $e");
        // You can also show a snackbar or dialog with an error message.
      }
    }
  }

  Future<void> _updateProfileImage() async {
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? pickedImage =
      await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String fileName = path.basename(pickedImage.path);
        Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profile_images/$fileName');

        UploadTask uploadTask = firebaseStorageRef.putFile(File(pickedImage.path));

        await uploadTask.whenComplete(() async {
          String updatedImageUrl = await firebaseStorageRef.getDownloadURL();

          setState(() {
          profileImageUrl = updatedImageUrl;
          });
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}



