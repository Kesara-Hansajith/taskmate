import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskmate/profile/client/profile_client_addphoto.dart';
import 'package:taskmate/profile/client/user_model1.dart';

import '../../constants.dart';
import '../freelancer/profile_freelancer.dart';

class ProfileClient extends StatefulWidget {
  const ProfileClient({Key? key}) : super(key: key);

  @override
  _ProfileClientState createState() => _ProfileClientState();
}

class _ProfileClientState extends State<ProfileClient> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();



  String existingUserId = 'your_existing_user_id';
  String? profileImageUrl;
  String? selectedGender;
  String? selectedProvince;
  String? selectedSkills;
  bool dataSubmitted = false;

  get emailRegex => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', caseSensitive: false, multiLine: false,);
  get phoneRegex => RegExp(r'^[0-9]{10}$', caseSensitive: false, multiLine: false,);
  get _urlRegex => RegExp(r"^(https?://)?([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(/\S*)?$");
  final _city1Regex = RegExp(r'^[a-zA-Z0-9\s]+$');


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
                const Center(
                  child: Text(
                    'Set Up Your',
                    style: kHeadingTextStyle,),),

                Center(
                  child: Text('Client Profile', style: TextStyle(fontSize: 25,color: Color(0xFF16056B),fontWeight: FontWeight.bold, ).copyWith(height: 1.0),),),

                 UserDataGatherTitle(
                  title: 'Your name*',),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0,right: 10.0, bottom: 18.0),
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          hintText: 'first name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF4B4646)),),
                          filled: true,
                          fillColor: Color(0x4B4646),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4B4646),),),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';}
                          return null;
                        },),),),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10.0, bottom: 18.0),
            child: TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                hintText: 'last name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF4B4646)),),
                filled: true,
                fillColor: Color(0x4B4646),
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4B4646),),),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your last name';}
                return null;
              },),),),],),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0,right: 10.0, bottom: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UserDataGatherTitle(title: 'Birthday*'),
                          TextFormField(
                            controller: birthdayController,
                            onTap: () {
                              selectDate(context, birthdayController); // Show the date picker on tap
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xFF4B4646)),),
                              filled: true,
                              fillColor: Color(0x4B4646),
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B4646),),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    selectDate(context, birthdayController); // Show the date picker on icon tap
                                  },
                                  child: Icon(Icons.calendar_today),
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select your birthday';}
                              return null;},)],),),),
                    Expanded(
                      child: Padding(padding: const EdgeInsets.only(left:10.0,right: 10.0, bottom: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UserDataGatherTitle(title: 'Gender*'),
                          TextFormField(
                            controller: genderController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xFF4B4646)),),
                              filled: true,
                              fillColor: Color(0x4B4646),
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B4646),
                              ),
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select your gender';}
                              return null;},
                              onTap: () async {
                                // Open province selection dialog
                                final selectedValue = await showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select Gender'),
                                      content: DropdownButtonFormField<String>(
                                        value: selectedGender,
                                        items: [
                                          DropdownMenuItem(value: 'Male', child: Text('Male'),),
                                          DropdownMenuItem(value: 'Female', child: Text('Female'),),
                                          DropdownMenuItem(value: 'Other', child: Text('Other'),)],
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value;
                                          });},
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 8.0,),),),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, selectedGender);},
                                          child: Text('OK'),),],);},);
                                if (selectedValue != null) {
                                  genderController.text = selectedValue;}})],),),),],),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserDataGatherTitle(title: 'Address*'),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                            hintText: 'Apartment/suite number',
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
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: streetController,
                        decoration: InputDecoration(
                          hintText: 'Street name',
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
                            return 'Please enter your street name';}
                          return null;},),],),),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0,right: 10.0, bottom: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const UserDataGatherTitle(title: 'City*'),
                            TextFormField(
                              controller: cityController,
                              decoration: InputDecoration(
                                hintText: 'city',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFF4B4646)),),
                                  filled: true,
                                  fillColor: Color(0x4B4646),
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4B4646),),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select your birthday';}
                                if (!_city1Regex.hasMatch(value)) {
                                  return 'Please enter a valid name';}
                                return null;},)],),),),
                    Expanded(
                      child: Padding(padding: const EdgeInsets.only(left:10.0,right: 10.0, bottom: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const UserDataGatherTitle(title: 'State/Province*'),
                            TextFormField(
                                controller: provinceController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFF4B4646)),),
                                  filled: true,
                                  fillColor: Color(0x4B4646),
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4B4646),
                                  ),
                                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please select your province';}
                                  return null;},
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
    DropdownMenuItem(value: 'Central Province', child: Text('Central Province'),),
    DropdownMenuItem(value: 'Eastern Province', child: Text('Eastern province'),),
    DropdownMenuItem(value: 'North Central Province', child: Text('North Central Province'),),
    DropdownMenuItem(value: 'North Western Province', child: Text('North Western Province'),),
    DropdownMenuItem(value: 'Northern Province', child: Text('Northern Province'),),
    DropdownMenuItem(value: 'Sabaragamuwa Province', child: Text('Sabaragamuwa Province'),),
    DropdownMenuItem(value: 'Southern Province', child: Text('Southern Province'),),
    DropdownMenuItem(value: 'Uva Province', child: Text('Uva Province'),),
    DropdownMenuItem(value: 'Western Province', child: Text('Western Province'),),],
                                          onChanged: (value) {
                                            setState(() {
                                              selectedProvince = value;
                                            });},
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 8.0,),),),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, selectedProvince);},
                                            child: Text('OK'),),],);},);
                                  if (selectedValue != null) {
                                    provinceController.text = selectedValue;}})],),),),],),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 210.0, bottom: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserDataGatherTitle(title: 'ZIP/Postal code*'),
                      TextFormField(
                        controller: zipCodeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+$')),
                        ],
                        decoration: InputDecoration(
                          hintText: 'ZIP code',
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
                              return 'Please enter your zipcode ';}
                            return null;},),],),),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserDataGatherTitle(title: 'Phone number*'),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          hintText: 'Enter number',
                          prefixText: '+94 ',
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
                          else if (value.length != 9) {
                            return 'Please enter a valid phone number';
                          }
                          return null;},),],),),

                SizedBox(height: 16,),


                Center(
                  child:ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Validated successfully, submit the form
                        final client = UserModel1(
                          firstName: firstNameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          address: addressController.text.trim(),
                          zipcode: zipCodeController.text.trim(),
                          street: streetController.text.trim(),
                          birthday: birthdayController.text.trim(),
                          gender: genderController.text.trim(),
                          province: provinceController.text.trim(),
                          city: cityController.text.trim(),
                          phoneNo: phoneController.text.trim(),
                          profilePhotoUrl: profileImageUrl,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileClientAddphoto(client: client),
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
        )
      ),
    );
  }
}

class UserDataGatherTitle extends StatelessWidget {
  const UserDataGatherTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13, // Set the desired font size
          color: Color(0xFF4B4646), // Set the desired font color
          fontWeight: FontWeight.bold,),),);}}