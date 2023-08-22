

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String firstName ;
  final String lastName ;
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
  final String? imageurl1;
  final String? imageurl2;
  final String? imageurl3;
  final String title;
  final String itemdes;
  final String services ;
  final String sociallink ;
  final String hourlyRate ;
  final String? profilePhotoUrl;

   UserModel ({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.zipcode,
    required this.birthday,
    required this.gender,
    required this.province,
    required this.city,
     required this.street,
    required this.bio,
    required this.skills,
     required this.imageurl1,
     required this.imageurl2,
     required this.imageurl3,
     required this.title,
     required this.itemdes,
    required this.services,
    required this.sociallink,
    required this.hourlyRate,
    required this.phoneNo,
    this.profilePhotoUrl,
  });

  Map<String, dynamic> toJson(){
    return {

      "FirstName": firstName,
      "LastName": lastName,
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
      "ImageUrl1": imageurl1,
      "ImageUrl2": imageurl2,
      "ImageUrl3": imageurl3,
      "Title": title,
      "ItemDes": itemdes,
      "Services" : services,
      "SocialLink" : sociallink,
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
      address: json['Address'] ?? '',
      zipcode: json['ZipCode'] ?? '',
      birthday: json['Birthday'],
      gender: json['Gender'],
      province: json['Province'] ?? '',
      city: json['City'] ?? '',
      street: json['Street'] ?? '',
      bio: json['Bio'] ?? '',
      skills: json['Skills'] ?? '',
      imageurl1: json['ImageUrl1']  ,
      imageurl2: json['ImageUrl2'] ,
      imageurl3: json['ImageUrl3'] ,
      title: json['Title'] ?? '',
      itemdes: json['ItemDes'] ?? '',
      services: json['Services'] ?? '',
      sociallink: json['SocialLink'] ?? '',
      hourlyRate: json['HourlyRate'] ?? '',
      phoneNo: json['Phone'] ?? '',
      profilePhotoUrl: json['ProfilePhotoUrl'],
    );
  }


}