

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String firstName ;
  final String lastName ;
  final String email;
  final String password;
  final String address ;
  final String zipcode ;
  final String birthday ;
  final String gender ;
  final String province ;
  final String city ;
  final String street;
  final String phoneNo ;
  final String bio ;
  final String skills ;
  final String services ;
  final String sociallink ;
  final String professionalrole;
  final String hourlyRate ;
  final String? profilePhotoUrl;

   UserModel ({
    this.id,
    required this.firstName,
    required this.lastName,
     required this.email,
     required this.password,
    required this.address,
    required this.zipcode,
    required this.birthday,
    required this.gender,
    required this.province,
    required this.city,
     required this.street,
    required this.bio,
    required this.skills,
    required this.services,
    required this.sociallink,
     required this.professionalrole,
    required this.hourlyRate,
    required this.phoneNo,
    this.profilePhotoUrl,
  });

  Map<String, dynamic> toJson(){
    return {

      "FirstName": firstName,
      "LastName": lastName,
      "UserName": email,
      "Password": password,
      "Address": address,
      "ZipCode": zipcode,
      "Birthday": birthday,
      "Gender": gender,
      "Province": province,
      "City":city,
      "Street":street,
      "Phone": phoneNo,
      "Bio" : bio,
      "Sills": skills,
      "Services" : services,
      "SocialLink" : sociallink,
      "ProfessionalRole" : professionalrole,
      "HourlyRate" : hourlyRate,
      "ProfilePhotoUrl": profilePhotoUrl,
    };
  }

  // Named constructor to convert Firestore data to UserModel1 object
  factory UserModel.fromJson(Map<String, dynamic> json, String documentId) {
    return UserModel(
      id: documentId,
      // Use the null-aware operator to provide a default value
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      email: json['Email'] ?? '',
      password: json['Password'] ?? '',
      address: json['Address'] ?? '',
      zipcode: json['ZipCode'] ?? '',
      birthday: json['Birthday'],
      gender: json['Gender'],
      province: json['Province'] ?? '',
      city: json['City'] ?? '',
      street: json['Street'] ?? '',
      bio: json['Bio'] ?? '',
      skills: json['Skills'] ?? '',
      services: json['Services'] ?? '',
      sociallink: json['SocialLink'] ?? '',
      professionalrole: json['ProfessionalRole'] ?? '',
      hourlyRate: json['HourlyRate'] ?? '',
      phoneNo: json['Phone'] ?? '',
      profilePhotoUrl: json['ProfilePhotoUrl'],
    );
  }


}