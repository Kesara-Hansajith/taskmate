

class UserModel {
  final String? id;
  final String firstName ;
  final String lastName ;
  final String address ;
  final String zipcode ;
  final String province ;
  final String city ;
  final String email ;
  final String phoneNo ;
  final String bio ;
  final String skills ;
  final String services ;
  final String sociallink ;
  final String professionalRole ;
  final String hourlyRate ;
  final String password ;
  final String? profilePhotoUrl;

  const UserModel ({
    this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.zipcode,
    required this.province,
    required this.city,
    required this.bio,
    required this.skills,
    required this.services,
    required this.sociallink,
    required this.professionalRole,
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
      "Province": province,
      "City":city,
      "Email": email,
      "Phone": phoneNo,
      "Bio" : bio,
      "Sills": skills,
      "Services" : services,
      "SocialLink" : sociallink,
      "ProfessionalRole": professionalRole,
      "HourlyRate" : hourlyRate,
      "Password": password,
      "ProfilePhotoUrl": profilePhotoUrl,
    };
  }
}