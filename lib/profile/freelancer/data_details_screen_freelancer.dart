import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/profile/client/user_model1.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';

class DataDetailsScreenFreelancer extends StatelessWidget {
  final UserModel user;
  final String? profileImageUrl;


  DataDetailsScreenFreelancer({ required this.user,
    this.profileImageUrl,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Photo in Circle
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(profileImageUrl ?? ''),
                ),
              ),
              SizedBox(height: 8),





              SizedBox(height: 6),
              // First Name + Last Name
              Center(
                child: Text(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 40),



              // Address with Circular Border
              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('Address: ${user.address}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('ZipCode: ${user.zipcode}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),


              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('Province: ${user.province}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('City: ${user.city}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('Bio: ${user.bio}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('Phone No: ${user.phoneNo}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('Skills: ${user.skills}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('Services: ${user.services}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('Social Link: ${user.sociallink}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: 300, // Adjust the width as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text('Hourly Rate: ${user.hourlyRate}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}